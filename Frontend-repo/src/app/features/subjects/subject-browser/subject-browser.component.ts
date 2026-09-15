import { Component, OnInit, inject, signal, computed } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { SubjectsService } from '../services/subjects.service';
import { MacnzSubject, SubjectTreeNode, CodingEntry, ChartItem } from '../models/subject.model';
import { CodingFormComponent } from '../coding-form/coding-form.component';
import { SubjectFormComponent } from '../subject-form/subject-form.component';

@Component({
  standalone: false,
  selector: 'app-subject-browser',
  templateUrl: './subject-browser.component.html',
  styleUrls: ['./subject-browser.component.scss']
})
export class SubjectBrowserComponent implements OnInit {

  private subjectsService = inject(SubjectsService);
  private dialog          = inject(MatDialog);
  private snack           = inject(MatSnackBar);
  private t               = inject(TranslateService);

  allSubjects      = signal<MacnzSubject[]>([]);
  isLoading        = signal(true);
  selectedSubject  = signal<MacnzSubject | null>(null);
  searchTerm       = signal('');
  codingEntries    = signal<CodingEntry[]>([]);
  relatedCharts    = signal<ChartItem[]>([]);
  isLoadingCharts  = signal(false);
  codingCols       = ['level', 'code', 'description', 'actions'];

  tree = computed(() => this.buildTree(this.allSubjects()));

  filteredTree = computed(() => {
    const term = this.searchTerm().toLowerCase();
    if (!term) return this.tree();
    return this.filterTree(this.tree(), term);
  });

  ngOnInit(): void {
    this.loadSubjects();
    this.loadCoding();
  }

  onSelectSubject(subject: MacnzSubject): void {
    this.selectedSubject.set(subject);
    this.relatedCharts.set([]);
    this.isLoadingCharts.set(true);
    this.subjectsService.getRelatedCharts(subject.code).subscribe({
      next: r => {
        this.relatedCharts.set(r.data.content);
        this.isLoadingCharts.set(false);
      },
      error: () => this.isLoadingCharts.set(false)
    });
  }

  getNarrowerTerms(): MacnzSubject[] {
    const sel = this.selectedSubject();
    if (!sel) return [];
    return this.allSubjects().filter(s =>
      s.code.startsWith(sel.code) && s.code !== sel.code && s.code.length > sel.code.length
    );
  }

  getRelatedTerms(): MacnzSubject[] {
    const sel = this.selectedSubject();
    if (!sel) return [];
    const prefix = sel.code.substring(0, Math.max(1, sel.code.length - 1));
    return this.allSubjects().filter(s =>
      s.code.startsWith(prefix) && s.code !== sel.code && s.level === sel.level
    );
  }

  openSubjectDialog(mode: 'create' | 'edit', subjectCode?: string, parentCode?: string): void {
    const subject = subjectCode ? this.findSubject(subjectCode) : undefined;
    const parent = parentCode ? this.findSubject(parentCode) : undefined;
    this.dialog.open(SubjectFormComponent, {
      width: '460px',
      data: { mode, subject, parent, allSubjects: this.allSubjects() }
    })
      .afterClosed()
      .subscribe(saved => { if (saved) this.loadSubjects(); });
  }

  onDeleteSubject(code: string): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.subjectsService.deleteSubject(code).subscribe({
      next: () => {
        this.snack.open(this.t.instant('SUBJECTS.FORM.DELETED'), '', { duration: 3000 });
        if (this.selectedSubject()?.code === code) this.selectedSubject.set(null);
        this.loadSubjects();
      },
      error: () => {}
    });
  }

  findSubject(code: string): MacnzSubject | undefined {
    return this.allSubjects().find(s => s.code === code);
  }

  private loadSubjects(): void {
    this.isLoading.set(true);
    this.subjectsService.getAllSubjects().subscribe({
      next: r => { this.allSubjects.set(r.data); this.isLoading.set(false); },
      error: () => this.isLoading.set(false)
    });
  }

  openCodingDialog(mode: 'create' | 'edit', entry?: CodingEntry): void {
    this.dialog.open(CodingFormComponent, { width: '440px', data: { mode, entry } })
      .afterClosed()
      .subscribe(saved => { if (saved) this.loadCoding(); });
  }

  onDeleteCoding(level: string, code: string): void {
    if (!confirm(this.t.instant('APP.CONFIRM_DELETE'))) return;
    this.subjectsService.deleteCoding(level, code).subscribe({
      next: () => {
        this.snack.open(this.t.instant('SUBJECTS.CODING.DELETED'), '', { duration: 3000 });
        this.loadCoding();
      },
      error: () => {}
    });
  }

  private loadCoding(): void {
    this.subjectsService.getAllCoding().subscribe({
      next: r => this.codingEntries.set(r.data),
      error: () => {}
    });
  }

  private buildTree(subjects: MacnzSubject[]): SubjectTreeNode[] {
    const roots: SubjectTreeNode[] = [];
    const map = new Map<string, SubjectTreeNode>();
    const sorted = [...subjects].sort((a, b) => a.code.localeCompare(b.code));
    for (const s of sorted) {
      const node: SubjectTreeNode = { code: s.code, description: s.description, level: s.level, children: [] };
      map.set(s.code, node);
      let placed = false;
      for (let len = s.code.length - 1; len >= 1; len--) {
        const parent = map.get(s.code.substring(0, len));
        if (parent) { parent.children.push(node); placed = true; break; }
      }
      if (!placed) roots.push(node);
    }
    return roots;
  }

  private filterTree(nodes: SubjectTreeNode[], term: string): SubjectTreeNode[] {
    const result: SubjectTreeNode[] = [];
    for (const node of nodes) {
      const matches = node.description.toLowerCase().includes(term) || node.code.toLowerCase().includes(term);
      const filteredChildren = this.filterTree(node.children, term);
      if (matches || filteredChildren.length > 0) result.push({ ...node, children: filteredChildren });
    }
    return result;
  }
}

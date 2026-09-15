import { Component, EventEmitter, OnInit, Output, inject, signal } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Observable, of, debounceTime, switchMap } from 'rxjs';
import { SubjectsService } from '../services/subjects.service';
import { MacnzSubject } from '../models/subject.model';

@Component({
  standalone: false,
  selector: 'app-subject-search',
  templateUrl: './subject-search.component.html',
  styleUrls: ['./subject-search.component.scss']
})
export class SubjectSearchComponent implements OnInit {

  @Output() subjectSelected = new EventEmitter<MacnzSubject>();

  private subjectsService = inject(SubjectsService);

  searchControl = new FormControl('');
  allSubjects = signal<MacnzSubject[]>([]);
  filteredSubjects$: Observable<MacnzSubject[]> = of([]);

  ngOnInit(): void {
    this.subjectsService.getAllSubjects().subscribe({
      next: (res) => this.allSubjects.set(res.data)
    });

    this.filteredSubjects$ = this.searchControl.valueChanges.pipe(
      debounceTime(300),
      switchMap(term => {
        if (!term || term.length < 2) return of([]);
        const lower = term.toLowerCase();
        const filtered = this.allSubjects().filter(s =>
          s.description.toLowerCase().includes(lower) || s.code.toLowerCase().includes(lower)
        );
        return of(filtered.slice(0, 20));
      })
    );
  }

  onSelected(subject: MacnzSubject): void {
    this.subjectSelected.emit(subject);
    this.searchControl.setValue('');
  }

  displaySubject(subject: MacnzSubject): string {
    return subject ? `${subject.code} - ${subject.description}` : '';
  }
}

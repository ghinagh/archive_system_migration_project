import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BooksService } from '../services/books.service';
import { CatalogueService } from '../../catalogue/services/catalogue.service';
import { Book, BookSubject, BookDescriptor, BookSeries } from '../models/book.model';
import { CatalogueLinkedAuthor } from '../../catalogue/models/catalogue.models';

@Component({
  standalone: false,
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.scss']
})
export class BookDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(BooksService);
  private catalogueSvc = inject(CatalogueService);

  item = signal<Book | null>(null);
  series = signal<BookSeries | null>(null);
  linkedAuthors = signal<CatalogueLinkedAuthor[]>([]);
  subjects = signal<BookSubject[]>([]);
  descriptors = signal<BookDescriptor[]>([]);
  isLoading = signal(true);

  ngOnInit(): void {
    const appNo = this.route.snapshot.paramMap.get('appNo');
    if (!appNo) { this.router.navigate(['/books']); return; }

    this.svc.getById(appNo).subscribe({
      next: res => {
        this.item.set(res.data);
        this.isLoading.set(false);
        this.loadRelated(appNo);
      },
      error: () => { this.isLoading.set(false); this.router.navigate(['/books']); }
    });
  }

  private loadRelated(appNo: string): void {
    this.svc.getSeries(appNo).subscribe({ next: r => this.series.set(r.data), error: () => {} });
    this.catalogueSvc.getLinkedAuthors(appNo).subscribe({ next: r => this.linkedAuthors.set(r.data), error: () => {} });
    this.svc.getSubjects(appNo).subscribe({ next: r => this.subjects.set(r.data), error: () => {} });
    this.svc.getDescriptors(appNo).subscribe({ next: r => this.descriptors.set(r.data), error: () => {} });
  }

  goBack(): void { this.router.navigate(['/books']); }
  edit(): void { this.router.navigate(['/books', this.item()!.appNo, 'edit']); }
}

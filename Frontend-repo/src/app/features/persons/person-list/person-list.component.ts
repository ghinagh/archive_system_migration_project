import { Component, OnInit, inject, signal } from '@angular/core';
import { Router } from '@angular/router';
import { PageEvent } from '@angular/material/paginator';
import { PersonsService } from '../services/persons.service';
import { Person } from '../models/person.model';
import { PERM_CREATE } from '../../../shared/models/permission-constants';

@Component({
  standalone: false,
  selector: 'app-person-list',
  templateUrl: './person-list.component.html',
  styleUrls: ['./person-list.component.scss']
})
export class PersonListComponent implements OnInit {

  protected readonly PERM_CREATE = PERM_CREATE;

  private personsService = inject(PersonsService);
  private router = inject(Router);

  displayedColumns = ['prsNo', 'name', 'institution', 'phone', 'email', 'entity', 'actions'];

  items = signal<Person[]>([]);
  totalElements = signal(0);
  pageSize = signal(10);
  pageIndex = signal(0);
  isLoading = signal(false);
  errorMessage = signal<string | null>(null);

  filterName = signal('');
  filterEntity = signal('');

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.isLoading.set(true);
    this.errorMessage.set(null);

    const name = this.filterName() || undefined;
    const entity = this.filterEntity() || undefined;

    this.personsService.getAll(this.pageIndex(), this.pageSize(), name, entity).subscribe({
      next: (res) => {
        this.items.set(res.data.content);
        this.totalElements.set(res.data.totalElements);
        this.isLoading.set(false);
      },
      error: (err) => {
        this.errorMessage.set(err.message);
        this.isLoading.set(false);
      }
    });
  }

  onPageChange(event: PageEvent): void {
    this.pageIndex.set(event.pageIndex);
    this.pageSize.set(event.pageSize);
    this.loadData();
  }

  applyFilter(): void {
    this.pageIndex.set(0);
    this.loadData();
  }

  clearFilter(): void {
    this.filterName.set('');
    this.filterEntity.set('');
    this.pageIndex.set(0);
    this.loadData();
  }

  viewDetail(prsNo: string): void {
    this.router.navigate(['/persons', prsNo]);
  }

  addNew(): void {
    this.router.navigate(['/persons', 'new']);
  }
}

import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { StaffService } from '../services/staff.service';
import { Staff } from '../models/person.model';

@Component({
  standalone: false,
  selector: 'app-staff-detail',
  templateUrl: './staff-detail.component.html',
  styleUrls: ['./staff-detail.component.scss']
})
export class StaffDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private staffService = inject(StaffService);

  item = signal<Staff | null>(null);
  isLoading = signal(true);

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (!id) return;

    this.staffService.getById(id).subscribe({
      next: (res) => {
        this.item.set(res.data);
        this.isLoading.set(false);
      },
      error: () => {
        this.isLoading.set(false);
        this.router.navigate(['/persons']);
      }
    });
  }

  goBack(): void {
    this.router.navigate(['/persons']);
  }
}

import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { ArchiveService } from '../services/archive.service';
import { ChartItem } from '../models/archive.model';
import { ChartDeleteConfirmDialogComponent } from '../chart-delete-confirm-dialog/chart-delete-confirm-dialog.component';

@Component({
  standalone: false,
  selector: 'app-archive-detail',
  templateUrl: './archive-detail.component.html',
  styleUrls: ['./archive-detail.component.scss']
})
export class ArchiveDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private archiveService = inject(ArchiveService);
  private dialog = inject(MatDialog);

  chart = signal<ChartItem | null>(null);
  isLoading = signal(true);
  chartId = 0;

  ngOnInit(): void {
    this.chartId = Number(this.route.snapshot.paramMap.get('id'));
    this.archiveService.getById(this.chartId).subscribe({
      next: res => { this.chart.set(res.data); this.isLoading.set(false); },
      error: () => { this.isLoading.set(false); this.router.navigate(['/archive']); }
    });
  }

  onEdit(): void { this.router.navigate(['/archive', this.chartId, 'edit']); }

  onDelete(): void {
    this.dialog.open(ChartDeleteConfirmDialogComponent, {
      width: '520px',
      data: { chartId: this.chartId }
    });
  }

  goBack(): void { this.router.navigate(['/archive']); }
}

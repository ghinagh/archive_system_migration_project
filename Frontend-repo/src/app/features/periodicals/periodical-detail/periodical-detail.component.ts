import { Component, OnInit, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { PeriodicalsService } from '../services/periodicals.service';
import { Periodical } from '../models/periodical.model';

@Component({
  standalone: false,
  selector: 'app-periodical-detail',
  templateUrl: './periodical-detail.component.html',
  styleUrls: ['./periodical-detail.component.scss']
})
export class PeriodicalDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private svc = inject(PeriodicalsService);
  private t = inject(TranslateService);

  item = signal<Periodical | null>(null);
  isLoading = signal(true);

  ngOnInit(): void {
    const perNo = this.route.snapshot.paramMap.get('perNo');
    if (!perNo) return;

    this.svc.getById(Number(perNo)).subscribe({
      next: res => { this.item.set(res.data); this.isLoading.set(false); },
      error: () => { this.isLoading.set(false); this.router.navigate(['/periodicals']); }
    });
  }

  goBack(): void {
    this.router.navigate(['/periodicals']);
  }
}

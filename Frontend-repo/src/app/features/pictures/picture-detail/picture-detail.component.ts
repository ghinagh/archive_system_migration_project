import { Component, OnInit, computed, inject, signal } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { MatDialog } from '@angular/material/dialog';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TranslateService } from '@ngx-translate/core';
import { PicturesService } from '../services/pictures.service';
import { MediaResolveInfo, Picture } from '../models/picture.model';
import { VideoPreviewDialogComponent } from '../video-preview-dialog/video-preview-dialog.component';

@Component({
  standalone: false,
  selector: 'app-picture-detail',
  templateUrl: './picture-detail.component.html',
  styleUrls: ['./picture-detail.component.scss']
})
export class PictureDetailComponent implements OnInit {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private dialog = inject(MatDialog);
  private picturesService = inject(PicturesService);
  private snackBar = inject(MatSnackBar);
  private translate = inject(TranslateService);

  // Type codes from the ARRAYS lookup table that identify a record as video.
  // Align these with the actual values stored in the database for picTyp.
  private readonly VIDEO_TYPE_CODES = new Set([3, 4]);

  item = signal<Picture | null>(null);
  isLoading = signal(true);
  isEditing = signal(false);

  mediaInfo = signal<MediaResolveInfo | null>(null);
  mediaLoading = signal(false);
  mediaChecked = signal(false);

  isVideo = computed(() => {
    const typ = this.item()?.picTyp;
    return typ != null && this.VIDEO_TYPE_CODES.has(typ);
  });

  ngOnInit(): void {
    const id = this.route.snapshot.paramMap.get('id');
    if (!id) return;

    this.picturesService.getById(id).subscribe({
      next: (res) => {
        this.item.set(res.data);
        this.isLoading.set(false);
      },
      error: () => {
        this.isLoading.set(false);
        this.router.navigate(['/pictures']);
      }
    });
  }

  toggleEdit(): void {
    this.isEditing.update(v => !v);
  }

  onSaved(): void {
    this.isEditing.set(false);
    const picNo = this.item()?.picNo;
    if (picNo) {
      this.picturesService.getById(picNo).subscribe({
        next: (res) => this.item.set(res.data)
      });
    }
    this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
  }

  onDelete(): void {
    const picNo = this.item()?.picNo;
    if (!picNo || !confirm(this.translate.instant('APP.CONFIRM_DELETE'))) return;

    this.picturesService.delete(picNo).subscribe({
      next: () => {
        this.snackBar.open(this.translate.instant('APP.SUCCESS'), this.translate.instant('APP.CANCEL'), { duration: 3000 });
        this.router.navigate(['/pictures']);
      }
    });
  }

  goBack(): void {
    this.router.navigate(['/pictures']);
  }

  checkMedia(): void {
    const ngNo = this.item()?.picNgNo?.trim();
    if (!ngNo) return;
    this.mediaLoading.set(true);
    this.picturesService.resolveMedia(ngNo).subscribe({
      next: (res) => {
        this.mediaInfo.set(res.data ?? null);
        this.mediaChecked.set(true);
        this.mediaLoading.set(false);
      },
      error: () => this.mediaLoading.set(false)
    });
  }

  downloadFile(): void {
    const ngNo = this.item()?.picNgNo?.trim();
    if (!ngNo) return;
    this.picturesService.downloadMedia(ngNo).subscribe({
      next: (blob) => {
        const url = URL.createObjectURL(blob);
        const anchor = document.createElement('a');
        anchor.href = url;
        anchor.download = ngNo;
        anchor.click();
        URL.revokeObjectURL(url);
      }
    });
  }

  openInTab(): void {
    const ngNo = this.item()?.picNgNo?.trim();
    if (!ngNo) return;
    this.picturesService.downloadMedia(ngNo).subscribe({
      next: (blob) => {
        const url = URL.createObjectURL(blob);
        window.open(url, '_blank');
        setTimeout(() => URL.revokeObjectURL(url), 30000);
      }
    });
  }

  openVideoPreview(): void {
    const ngNo = this.item()?.picNgNo?.trim();
    if (!ngNo) return;
    this.dialog.open(VideoPreviewDialogComponent, {
      data: { stockNo: ngNo, title: this.item()?.picTit ?? '' },
      width: '680px',
      maxWidth: '95vw',
      panelClass: 'video-preview-panel'
    });
  }
}

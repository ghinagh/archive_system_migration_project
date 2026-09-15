import { Component, OnDestroy, OnInit, inject, signal } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { PicturesService } from '../services/pictures.service';

export interface VideoPreviewDialogData {
  stockNo: string;
  title: string;
}

@Component({
  standalone: false,
  selector: 'app-video-preview-dialog',
  templateUrl: './video-preview-dialog.component.html',
  styleUrls: ['./video-preview-dialog.component.scss']
})
export class VideoPreviewDialogComponent implements OnInit, OnDestroy {

  readonly data = inject<VideoPreviewDialogData>(MAT_DIALOG_DATA);
  private dialogRef = inject(MatDialogRef<VideoPreviewDialogComponent>);
  private picturesService = inject(PicturesService);

  blobUrl = signal<string | null>(null);
  isLoading = signal(true);
  loadError = signal(false);

  ngOnInit(): void {
    this.picturesService.downloadMedia(this.data.stockNo).subscribe({
      next: (blob) => {
        this.blobUrl.set(URL.createObjectURL(blob));
        this.isLoading.set(false);
      },
      error: () => {
        this.loadError.set(true);
        this.isLoading.set(false);
      }
    });
  }

  ngOnDestroy(): void {
    const url = this.blobUrl();
    if (url) URL.revokeObjectURL(url);
  }

  close(): void {
    this.dialogRef.close();
  }
}

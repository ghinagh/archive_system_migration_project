import { Component, ElementRef, Input, ViewChild } from '@angular/core';

const SUPPORTED_EXTENSIONS = new Set(['.mp4', '.webm', '.ogg']);
const MIME_MAP: Record<string, string> = {
  '.mp4':  'video/mp4',
  '.webm': 'video/webm',
  '.ogg':  'video/ogg'
};

@Component({
  standalone: false,
  selector: 'app-video-preview',
  templateUrl: './video-preview.component.html',
  styleUrls: ['./video-preview.component.scss']
})
export class VideoPreviewComponent {
  @Input() videoUrl = '';
  @Input() title = '';

  @ViewChild('videoEl') videoRef!: ElementRef<HTMLVideoElement>;

  get detectedExtension(): string {
    if (!this.videoUrl || this.videoUrl.startsWith('blob:')) return '';
    try {
      const pathname = new URL(this.videoUrl).pathname;
      const idx = pathname.lastIndexOf('.');
      return idx >= 0 ? pathname.substring(idx).toLowerCase() : '';
    } catch {
      return '';
    }
  }

  get isSupportedFormat(): boolean {
    if (!this.videoUrl) return false;
    if (this.videoUrl.startsWith('blob:')) return true;
    const ext = this.detectedExtension;
    return ext === '' || SUPPORTED_EXTENSIONS.has(ext);
  }

  get mimeType(): string {
    return MIME_MAP[this.detectedExtension] ?? '';
  }

  requestFullscreen(): void {
    const el = this.videoRef?.nativeElement;
    if (el?.requestFullscreen) {
      el.requestFullscreen();
    }
  }
}

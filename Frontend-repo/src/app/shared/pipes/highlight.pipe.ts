import { Pipe, PipeTransform, inject } from '@angular/core';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';

@Pipe({ name: 'highlight', standalone: false })
export class HighlightPipe implements PipeTransform {

  private sanitizer = inject(DomSanitizer);

  /**
   * Legacy HighlightWords (USER_INTERFACE1.frm:4938-4952) picks out the searched word in the
   * title and the abstract. The search box is tokenised on whitespace and each token is
   * matched independently, so the highlighter splits the same way — matching the phrase as
   * one literal string would leave a multi-word search with nothing highlighted.
   */
  transform(text: string | null | undefined, term: string | null | undefined): SafeHtml {
    const str = text ?? '';
    const tokens = (term ?? '').trim().split(/\s+/).filter(t => t.length > 0);
    if (tokens.length === 0) return str;
    // Longest first, so a longer token wins over a shorter one it contains.
    const escaped = tokens
      .sort((a, b) => b.length - a.length)
      .map(t => t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'));
    const regex = new RegExp(`(${escaped.join('|')})`, 'giu');
    return this.sanitizer.bypassSecurityTrustHtml(
      str.replace(regex, '<mark class="highlight">$1</mark>')
    );
  }
}

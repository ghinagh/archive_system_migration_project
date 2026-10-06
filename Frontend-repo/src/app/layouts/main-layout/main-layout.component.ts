import { Component, OnInit, DestroyRef, HostListener, inject, signal, computed } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { ConnectedPosition } from '@angular/cdk/overlay';
import { NavigationEnd, Router } from '@angular/router';
import { filter } from 'rxjs';
import { TranslateService } from '@ngx-translate/core';
import { AuthService } from '../../core/services/auth.service';
import { TokenService } from '../../core/services/token.service';

interface NavItem {
  icon?: string;
  labelKey: string;
  route?: string;
  queryParams?: Record<string, string>;
  adminOnly?: boolean;
  disabled?: boolean;
  children?: NavItem[];
}

@Component({
  standalone: false,
  selector: 'app-main-layout',
  templateUrl: './main-layout.component.html',
  styleUrls: ['./main-layout.component.scss']
})
export class MainLayoutComponent implements OnInit {

  private authService = inject(AuthService);
  private tokenService = inject(TokenService);
  private translate = inject(TranslateService);
  private router = inject(Router);
  private destroyRef = inject(DestroyRef);

  currentLang = signal<string>('ar');
  username = signal<string>('');
  userLevel = signal<string>('');
  sidenavOpened = signal(true);

  isAdmin = computed(() => this.userLevel() === 'A');

  // Mirrors the legacy ARCHIVE.frm menu shell's 3 top-level groups + 3 standalone
  // items 1:1, in the legacy top-level order (see menu-tree audit), plus a 4th
  // "Additions" group appended at the end for everything migrated/revived since
  // that has no legacy top-level ancestor.
  navItems: NavItem[] = [
    {
      icon: 'category', labelKey: 'NAV.GROUP_CLASSIFICATION',
      children: [
        { icon: 'topic', labelKey: 'NAV.SUBJECT_THESAURUS', route: '/subject-thesaurus' },
        { icon: 'style', labelKey: 'NAV.FORM_THESAURUS', route: '/form-thesaurus' },
        { icon: 'badge', labelKey: 'NAV.AUTHORS', route: '/authors' },
        { icon: 'construction', labelKey: 'NAV.RETRIEVAL_BUILDER', route: '/maintenance', queryParams: { tab: 'fields' }, adminOnly: true },
        { icon: 'lock_open', labelKey: 'NAV.UNLOCK_DOCUMENTS', route: '/maintenance', queryParams: { tab: 'unlock' }, adminOnly: true },
        { icon: 'admin_panel_settings', labelKey: 'NAV.USERS', route: '/users', adminOnly: true },
        { icon: 'tune', labelKey: 'NAV.RETRIEVAL_FIELDS', route: '/maintenance', queryParams: { tab: 'fields' }, adminOnly: true },
        { icon: 'backup', labelKey: 'NAV.DB_BACKUP', route: '/maintenance', queryParams: { tab: 'backup' }, adminOnly: true }
      ]
    },
    {
      icon: 'description', labelKey: 'NAV.GROUP_PROCESSING',
      children: [
        { icon: 'assignment', labelKey: 'NAV.DOCUMENTATION_FORM', route: '/catalogue/new' },
        { icon: 'import_contacts', labelKey: 'NAV.PERIODICALS', route: '/periodicals' }
      ]
    },
    {
      icon: 'find_in_page', labelKey: 'NAV.GROUP_RETRIEVAL',
      children: [
        { icon: 'insights', labelKey: 'NAV.GRAPHICAL_RETRIEVAL', route: '/retrieval' },
        { icon: 'folder_open', labelKey: 'NAV.FILES_RETRIEVAL', route: '/retrieval/additional-files' },
        { icon: 'inventory_2', labelKey: 'NAV.FILE_PULL_QUEUE', route: '/catalogue/files-retrieval' },
        { icon: 'video_library', labelKey: 'NAV.VIDEO_ORDERS', route: '/video-orders' },
        { icon: 'auto_stories', labelKey: 'NAV.PERIODICALS_RETRIEVAL', route: '/retrieval/periodicals' }
      ]
    },
    { icon: 'search', labelKey: 'NAV.SEARCH_SCREEN', route: '/catalogue/search' },
    { icon: 'assignment_late', labelKey: 'NAV.USAGE_REQUESTS', route: '/requests' },
    { icon: 'video_camera_back', labelKey: 'NAV.ARCHIVE_SEARCH', route: '/archive-search' },
    {
      icon: 'add_box', labelKey: 'NAV.GROUP_ADDITIONS',
      children: [
        { icon: 'photo_library', labelKey: 'NAV.PICTURES', route: '/pictures' },
        { icon: 'people', labelKey: 'NAV.PERSONS', route: '/persons' },
        { icon: 'swap_horiz', labelKey: 'NAV.BORROWING', route: '/borrowing' },
        { icon: 'archive', labelKey: 'NAV.ARCHIVE', route: '/archive' },
        { icon: 'location_on', labelKey: 'NAV.SITES', route: '/sites' },
        { icon: 'scanner', labelKey: 'NAV.DIGITIZATION', route: '/digitization' },
        { icon: 'assessment', labelKey: 'NAV.REPORTS', route: '/reports' },
        { icon: 'build', labelKey: 'NAV.MAINTENANCE', route: '/maintenance', adminOnly: true }
      ]
    }
  ];

  visibleNavItems = computed(() => this.filterByAccess(this.navItems));

  private filterByAccess(items: NavItem[]): NavItem[] {
    return items
      .filter(item => !item.adminOnly || this.isAdmin())
      .map(item => item.children
        ? { ...item, children: this.filterByAccess(item.children) }
        : item)
      .filter(item => !item.children || item.children.length > 0);
  }

  hoveredTopItem = signal<NavItem | null>(null);
  hoveredSecondItem = signal<NavItem | null>(null);

  private topCloseTimer?: ReturnType<typeof setTimeout>;
  private secondCloseTimer?: ReturnType<typeof setTimeout>;

  // The sidenav docks position="start" (physical right in Arabic/RTL, physical
  // left in English/LTR), so the flyout must open toward whichever side holds
  // the content area — the opposite side from the sidenav in each language.
  flyoutPositions = computed<ConnectedPosition[]>(() => {
    const isRtl = this.currentLang() === 'ar';
    const originSide = isRtl ? 'end' : 'start';
    const overlaySide = isRtl ? 'start' : 'end';
    return [
      { originX: originSide, originY: 'top', overlayX: overlaySide, overlayY: 'top' },
      { originX: originSide, originY: 'bottom', overlayX: overlaySide, overlayY: 'bottom' }
    ];
  });

  onTopEnter(item: NavItem): void {
    clearTimeout(this.topCloseTimer);
    this.hoveredTopItem.set(item);
    this.hoveredSecondItem.set(null);
  }

  onTopLeave(): void {
    this.topCloseTimer = setTimeout(() => {
      this.hoveredTopItem.set(null);
      this.hoveredSecondItem.set(null);
    }, 200);
  }

  cancelTopClose(): void {
    clearTimeout(this.topCloseTimer);
  }

  onSecondEnter(item: NavItem): void {
    clearTimeout(this.secondCloseTimer);
    this.hoveredSecondItem.set(item);
  }

  onSecondLeave(): void {
    this.secondCloseTimer = setTimeout(() => {
      this.hoveredSecondItem.set(null);
    }, 200);
  }

  cancelSecondClose(): void {
    clearTimeout(this.secondCloseTimer);
  }

  private closeAllFlyouts(): void {
    clearTimeout(this.topCloseTimer);
    clearTimeout(this.secondCloseTimer);
    this.hoveredTopItem.set(null);
    this.hoveredSecondItem.set(null);
  }

  ngOnInit(): void {
    const user = this.tokenService.getUser();
    if (user) {
      this.username.set(user.username);
      this.userLevel.set(user.level);
    }

    const savedLang = localStorage.getItem('app_lang') || 'ar';
    this.setLanguage(savedLang);

    // Flyouts only close on mouseleave; a click that navigates without the
    // mouse ever leaving the panel would otherwise leave it stuck open on
    // top of the newly-routed page.
    this.router.events
      .pipe(filter(e => e instanceof NavigationEnd), takeUntilDestroyed(this.destroyRef))
      .subscribe(() => this.closeAllFlyouts());
  }

  /**
   * Legacy ARCHIVE.frm menu shortcuts: m10 "المؤلفين ودور النشر" = Ctrl+K; m6 "المكنز الموضوعي" =
   * Ctrl+A and M2 "المكنز الشكلي" = Ctrl+B (both still key-protected by their route guards).
   * Ctrl+A / Ctrl+B keep their editing meaning inside text fields.
   */
  @HostListener('document:keydown', ['$event'])
  onMenuShortcut(event: KeyboardEvent): void {
    if (!event.ctrlKey || event.altKey || event.shiftKey || event.metaKey) return;
    if (event.code === 'KeyK') {
      event.preventDefault();
      this.router.navigate(['/authors']);
    } else if (event.code === 'KeyA' && !this.isEditable(event.target)) {
      event.preventDefault();
      this.router.navigate(['/subject-thesaurus']);
    } else if (event.code === 'KeyB' && !this.isEditable(event.target)) {
      event.preventDefault();
      this.router.navigate(['/form-thesaurus']);
    }
  }

  private isEditable(target: EventTarget | null): boolean {
    const el = target as HTMLElement | null;
    return !!el && (el.isContentEditable || ['INPUT', 'TEXTAREA', 'SELECT'].includes(el.tagName));
  }

  toggleLanguage(): void {
    const newLang = this.currentLang() === 'ar' ? 'en' : 'ar';
    this.setLanguage(newLang);
  }

  toggleSidenav(): void {
    this.sidenavOpened.update(v => !v);
  }

  logout(): void {
    this.authService.logout();
  }

  private setLanguage(lang: string): void {
    this.currentLang.set(lang);
    this.translate.use(lang);
    localStorage.setItem('app_lang', lang);
    document.documentElement.dir = lang === 'ar' ? 'rtl' : 'ltr';
    document.documentElement.lang = lang;
  }
}

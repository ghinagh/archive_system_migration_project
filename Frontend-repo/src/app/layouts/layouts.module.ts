import { NgModule } from '@angular/core';
import { OverlayModule } from '@angular/cdk/overlay';
import { SharedModule } from '../shared/shared.module';
import { MainLayoutComponent } from './main-layout/main-layout.component';

@NgModule({
  declarations: [MainLayoutComponent],
  imports: [SharedModule, OverlayModule],
  exports: [MainLayoutComponent]
})
export class LayoutsModule { }

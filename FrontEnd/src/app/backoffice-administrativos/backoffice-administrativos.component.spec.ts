import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BackofficeAdministrativosComponent } from './backoffice-administrativos.component';

describe('BackofficeAdministrativosComponent', () => {
  let component: BackofficeAdministrativosComponent;
  let fixture: ComponentFixture<BackofficeAdministrativosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BackofficeAdministrativosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BackofficeAdministrativosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

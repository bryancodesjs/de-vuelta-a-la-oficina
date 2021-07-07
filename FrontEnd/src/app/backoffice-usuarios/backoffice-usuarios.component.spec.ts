import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BackofficeUsuariosComponent } from './backoffice-usuarios.component';

describe('BackofficeUsuariosComponent', () => {
  let component: BackofficeUsuariosComponent;
  let fixture: ComponentFixture<BackofficeUsuariosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BackofficeUsuariosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BackofficeUsuariosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

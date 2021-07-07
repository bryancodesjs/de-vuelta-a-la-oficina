import { LOCALE_ID, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './navbar/navbar.component';
import { HomeComponent } from './home/home.component';
import { FooterComponent } from './footer/footer.component';
import { LoginComponent } from './components/login/login.component';
import { RegistroComponent } from './components/registro/registro.component';

import { registerLocaleData, HashLocationStrategy, LocationStrategy } from '@angular/common';

import { ReactiveFormsModule } from '@angular/forms';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { VistaPerfilComponent } from './vista-perfil/vista-perfil.component';
import { DashboardComponent } from './dashboard/dashboard.component';

import localeEsAr from '@angular/common/locales/es-AR';
import { BackofficeComponent } from './backoffice/backoffice.component';
import { BackofficeNavComponent } from './backoffice/backoffice-nav/backoffice-nav.component';
import { PublicacionesComponent } from './backoffice/publicaciones/publicaciones.component';
import { ArtistasComponent } from './backoffice/artistas/artistas.component';
import { ConfiguracionComponent } from './components/configuracion/configuracion.component';
import { BackofficeUsuariosComponent } from './backoffice-usuarios/backoffice-usuarios.component';
import { BackofficeAdministrativosComponent } from './backoffice-administrativos/backoffice-administrativos.component';

registerLocaleData(localeEsAr, 'es-Ar');

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    HomeComponent,
    FooterComponent,
    LoginComponent,
    RegistroComponent,
    VistaPerfilComponent,
    DashboardComponent,
    BackofficeComponent,
    BackofficeNavComponent,
    PublicacionesComponent,
    ArtistasComponent,
    ConfiguracionComponent,
    BackofficeUsuariosComponent,
    BackofficeAdministrativosComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule,
    NgbModule
  ],
  providers: [
    { provide: LOCALE_ID, useValue: 'es-Ar' },
    { provide: LocationStrategy, useClass: HashLocationStrategy }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }

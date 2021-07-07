import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { BackofficeComponent } from './backoffice/backoffice.component';
import { ConfiguracionComponent } from './components/configuracion/configuracion.component';
import { LoginComponent } from './components/login/login.component';
import { RegistroComponent } from './components/registro/registro.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { HomeComponent } from './home/home.component';
import { BackofficeUsuariosComponent } from './backoffice-usuarios/backoffice-usuarios.component';
import { BackofficeAdministrativosComponent } from './backoffice-administrativos/backoffice-administrativos.component';

// PARA PROTEGER LAS RUTAS QUE NECESITEN ESTAR LOGUEADO
import { AuthGuard } from './middleware/auth/auth.guard';
import { AuthGuard as Authorize } from './middleware/auth/authorize.guard';
import { VistaPerfilComponent } from './vista-perfil/vista-perfil.component';

const routes: Routes = [
  { path: '', component: HomeComponent, pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'registro', component: RegistroComponent },
  { path: 'perfil/:id', component: VistaPerfilComponent },
  { path: 'dashboard', component: DashboardComponent, canActivate: [AuthGuard] },
  { path: 'backoffice', component: BackofficeComponent, canActivate: [Authorize] },
  { path: 'configuracion', component: ConfiguracionComponent, canActivate: [AuthGuard] },
  { path: 'backoffice-usuarios', component: BackofficeUsuariosComponent},
  { path: 'backoffice-administrativos', component: BackofficeAdministrativosComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

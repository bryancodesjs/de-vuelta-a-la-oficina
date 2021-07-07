import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  private loggedIn = new BehaviorSubject<boolean>(false); // {1}

  get isLoggedIn() {
    return this.loggedIn.asObservable(); // {2}
  }

  constructor(  ) { }

  async infoUser( user: any, token: string, id: any )
  {
    await localStorage.setItem("currentUser", user);
    await localStorage.setItem("token", token);
    await localStorage.setItem("id", id);
  }

  setAdmin()
  {
    localStorage.setItem("_", "_");
  }

  setUser()
  {
    localStorage.setItem("_", "__");
  }

  getAdmin()
  {
    return localStorage.getItem("_");
  }

  getUser()
  {
    return localStorage.getItem("currentUser");
  }

  getToken(){
    return localStorage.getItem("token");
  }

  getId(): any {   
    return localStorage.getItem("id");
  }

  authorized(): boolean
  {
      if (this.getUser() != null && this.getUser() != '' && this.getAdmin() == '__' ) 
      {        
        return true;
      }
      else
      {
        return false;
      }
  }

  logOut()
  {
    localStorage.removeItem("currentUser");
    localStorage.removeItem("token");
    localStorage.removeItem("id");
    localStorage.removeItem("_");
  }

}

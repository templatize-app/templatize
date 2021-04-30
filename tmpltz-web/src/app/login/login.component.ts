import { DOCUMENT } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { AuthService } from '@auth0/auth0-angular';
import { MatToolbarModule } from '@angular/material/toolbar';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styles: [],
})

export class LoginComponent {
  constructor(@Inject(DOCUMENT) public document: Document, public auth: AuthService) {}

  showDelay = new FormControl(50);
  hideDelay = new FormControl(200);
}

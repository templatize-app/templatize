import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TemplateComponent } from './template/template.component';
import { TopNavComponent } from './topNav/topNav.component';
import { LogoutComponent } from './logout/logout.component';
import { LoginComponent } from './login/login.component';
import { NewtemplateComponent } from './newtemplate/newtemplate.component'
import { environment } from 'src/environments/environment';
import { PrivacyPolicyComponent } from './privacypolicy/privacypolicy.component';
import { FootersComponent } from './footer/footer.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatTooltipModule } from '@angular/material/tooltip';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatStep, MatStepperModule } from '@angular/material/stepper';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatListModule } from '@angular/material/list';
import { MatCardModule } from '@angular/material/card';

// Auth
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { AuthHttpInterceptor } from '@auth0/auth0-angular';
import { AuthModule } from '@auth0/auth0-angular';

import { QuillModule } from 'ngx-quill'

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    LogoutComponent,
    TemplateComponent,
    TopNavComponent,
    PrivacyPolicyComponent,
    FootersComponent,
    NewtemplateComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    MatToolbarModule,
    MatTooltipModule,
    MatIconModule,
    MatButtonModule,
    MatStepperModule,
    MatFormFieldModule,
    MatInputModule,
    MatListModule,
    MatCardModule,
    HttpClientModule,
    
    
    // Auth0 configuration
    AuthModule.forRoot({
      domain: environment.auth0Domain!,
      clientId: environment.auth0ClientID!,
      // The AuthHttpInterceptor configuration
      httpInterceptor: {
        allowedList: [
          {
            uri: 'https://@@grunt-API_DOMAIN/*',
          },
      ],
  },
    }),
    QuillModule.forRoot({
      modules: {
        toolbar: [
          ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
          ['blockquote', 'code-block'],
      
          [{ 'header': 1 }, { 'header': 2 }],               // custom button values
          [{ 'list': 'ordered'}, { 'list': 'bullet' }],
          [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
          [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
      
          [{ 'header': [1, 2, 3, 4, 5, false] }],
      
          [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
          [{ 'font': []}],
          [{ 'align': [] }],
      
          ['clean'],                                         // remove formatting button
      
          ['link', 'image']                                 // link and image, video
        ]
      }
    }),
    
    BrowserAnimationsModule,
  ],
  providers: [{provide: HTTP_INTERCEPTORS, useClass: AuthHttpInterceptor, multi: true}],
  bootstrap: [AppComponent]
})
export class AppModule { }

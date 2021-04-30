import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PrivacyPolicyComponent } from './privacypolicy/privacypolicy.component';
import { TemplateComponent } from './template/template.component';
import { NewtemplateComponent} from './newtemplate/newtemplate.component';

const routes: Routes = [ 
  {path: 'privacy', component: PrivacyPolicyComponent},
  {path: 'dashboard', component: TemplateComponent},
  {path: 'create-template', component: NewtemplateComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

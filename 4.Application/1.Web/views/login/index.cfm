<cfoutput>
    <header id="header">
        <h2>ERP-Traval Vai</h2>
        <!--- <div id="logo-group">
            <span id="logo"> Logo here </span>
        </div>
        <span id="extr-page-header-space"> <span class="hidden-mobile hiddex-xs">Need an account?</span> <a href="#event.buildLink( 'login.register')#" class="btn btn-danger">Create account</a> </span> --->
    </header>
    <div id="main" role="main">
        <div id="content" class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-offset-7 col-md-5 col-lg-4 col-lg-offset-8">
                    <div class="well no-padding">
                        <form action="#event.buildLink( 'login.attemptLogin' )#" id="login-form" class="smart-form client-form" novalidate="novalidate" method="post">
                            <header>
                                Sign In
                            </header>
                            <fieldset>
                                <section>
                                    <label class="label">Username</label>
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input type="text" name="username" class="form-control" placeholder="Username" required="">
                                        <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> Please enter email address/username</b>

                                    </label>
                                </section>
                                <section>
                                    <label class="label">Password</label>
                                    <label class="input"> <i class="icon-append fa fa-lock"></i>
                                        <input type="password" name="password" class="form-control" placeholder="Password" required="">
                                        <b class="tooltip tooltip-top-right"><i class="fa fa-lock txt-color-teal"></i> Enter your password</b> </label>
                                    <div class="note">
                                        <cfif structKeyExists(rc,"backlink")>

                                            <input type="hidden" value="#rc.backlink#" name="backlink">
                                        </cfif>
                                        <!--- <a href="#event.buildLink( 'login.forgotPassword')#">Forgot password?</a> --->
                                    </div>
                                </section>
                                <section>
                                    <label class="checkbox">
                                        <input type="checkbox" name="remember" checked="">
                                        <i></i>Stay signed in</label>
                                </section>
                            </fieldset>
                            <footer>
                                <cfif structKeyExists(rc,"message")>
                                    <label class="alert #rc.class# alert-login-fail">#rc.message#</label>
                                </cfif>
                                <button type="submit" class="btn btn-primary">
                                    Sign in
                                </button>
                            </footer>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!--- <div class="middle-box text-center loginscreen  animated fadeInDown">
        <div>
            <div>
                <h1 class="logo-name">Logo</h1>
            </div>
            <h3>Welcome to ERP - TravaVai</h3>
            <p>Perfectly designed and precisely prepared admin theme with over 50 pages with extra new web app views.
                <!--Continually expanded and constantly improved Inspinia Admin Them (IN+)-->
            </p>
            <p>Login in. To see it in action.</p>
            <form class="m-t" role="form" action="#event.buildLink( 'login.attemptLogin' )#">
                <div class="form-group">
                    <input type="text" name="username" class="form-control" placeholder="Username" required="">
                </div>
                <div class="form-group">
                    <input type="password" name="password" class="form-control" placeholder="Password" required="">
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">Login</button>

                <a href="#event.buildLink( 'login.forgotPassword')#"><small>Forgot password?</small></a>
                <p class="text-muted text-center"><small>Do not have an account?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="#event.buildLink( 'login.register')#">Create an account</a>
            </form>
            <p class="m-t"> <small>Inspinia ERP - TravaVai &copy; 2016</small> </p>
        </div>
    </div> --->
</cfoutput>
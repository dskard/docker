// Turn that annoying autocomplete popup REALLY off:
// (This actually has a UI but it's buried.)
user_pref("browser.urlbar.autocomplete.enabled", false);
user_pref("browser.urlbar.showPopup", false);
user_pref("browser.urlbar.showSearch", false);

// Turn off the download manager (0=download manager, 1=simple dialog?)
user_pref("browser.downloadmanager.behavior", 1);

user_pref("browser.sessionstore.resume_session_once",false);

// Remove the print dialog
user_pref("print.always_print_silent",true);
user_pref("print.show_print_progress",false);

// Disable firefox updates
user_pref("app.update.enabled", false);

// Turn off info bars that change the position of elements on the page
// after the page has loaded. you see this a lot on nees.org
user_pref("plugins.hide_infobar_for_missing_plugin",true);
user_pref("plugins.hide_infobar_for_outdated_plugin" : True);

// No startup or homepage
user_pref("browser.startup.page",0);
user_pref("extensions.checkCompatibility.nightly",false);
user_pref("browser.startup.homepage","about:blank");
user_pref("startup.homepage_welcome_url","about:blank");
user_pref("devtools.errorconsole.enabled",true);


// Disable extension updates and notifications.
user_pref("extensions.update.enabled",false);
user_pref("extensions.update.notifyUser",false);



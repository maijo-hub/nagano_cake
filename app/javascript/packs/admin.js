// app/javascript/packs/admin.js
import "jquery";
import "popper.js";
import "bootstrap";                        // ← BootstrapのJS（必須）
import "../stylesheets/admin/admin.scss";   // ← admin専用のSCSS（必須）

// Rails helper は admin ページでも不要なら不要だが、必要なら入れてください
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails && Rails.start && Rails.start();
Turbolinks && Turbolinks.start && Turbolinks.start();
ActiveStorage && ActiveStorage.start && ActiveStorage.start();

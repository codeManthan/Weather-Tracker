import "bootstrap";
import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

export default class extends Controller {
  static targets = [ "cityName" ];

  connect() {

  }

}
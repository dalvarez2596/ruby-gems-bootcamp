import { Controller } from "@hotwired/stimulus";

const TOOLBAR_ICONS = [
  {
    "current-icon-class": ".trix-button--icon-bold",
    "custom-icon": "<i class='fa-solid fa-bold'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-italic",
    "custom-icon": "<i class='fa-solid fa-italic'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-strike",
    "custom-icon": "<i class='fa-solid fa-strikethrough'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-link",
    "custom-icon": "<i class='fa-solid fa-link'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-heading-1",
    "custom-icon": "<i class='fa-solid fa-heading'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-quote",
    "custom-icon": "<i class='fa-solid fa-quote-right'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-code",
    "custom-icon": "<i class='fa-solid fa-code'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-bullet-list",
    "custom-icon": "<i class='fa-solid fa-list-ul'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-number-list",
    "custom-icon": "<i class='fa-solid fa-list-ol'></i>",
  },
  // {
  //   "current-icon-class": ".trix-button--icon-decrease-nesting-level",
  //   "custom-icon": "<i class='fa-solid fa-bold'></i>",
  // },
  // {
  //   "current-icon-class": ".trix-button--icon-increase-nesting-level",
  //   "custom-icon": "<i class='fa-solid fa-bold'></i>",
  // },
  {
    "current-icon-class": ".trix-button--icon-undo",
    "custom-icon": "<i class='fa-solid fa-rotate-left'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-redo",
    "custom-icon": "<i class='fa-solid fa-rotate-right'></i>",
  },
  {
    "current-icon-class": ".trix-button--icon-attach",
    "custom-icon": "<i class='fa-solid fa-paperclip'></i>",
  },
];

export default class extends Controller {
  connect() {
    addEventListener(
      "trix-initialize",
      this.initializeTrixCustomization.bind(this),
      true
    );
    addEventListener("trix-file-accept", this.preventFromUpload.bind(this));
  }
  initializeTrixCustomization(event) {
    // the code from bot could be use to add a new element to the view to underline.
    // Trix.config.textAttributes.underline = {
    //   tagName: "u",
    //   style: { textDecoration: "underline" },
    //   inheritable: true,
    //   parser: function (element) {
    //     let style = window.getComputedStyle(element);
    //     return style.textDecoration === "underline";
    //   },
    // };
    // let underlineElement = document.createElement("button");
    // underlineElement.setAttribute("type", "button");
    // underlineElement.setAttribute("data-trix-attribute", "underline");
    // underlineElement.setAttribute("data-trix-key", "u");
    // underlineElement.setAttribute("tabindex", -1);
    // underlineElement.setAttribute("title", "undeline");
    // underlineElement.classList.add(
    //   "trix-button",
    //   "trix-button--icon-underline"
    // );
    // underlineElement.innerHTML = "U";
    let trixToolbar = document.querySelector(".trix-button-row");
    // document
    //   .querySelector(".trix-button-group--text-tools")
    //   .appendChild(underlineElement);

    // This was use to iterate over clases and remove buttons
    // TOOLBAR_ICONS.forEach((cls) => {
    //   document.querySelector(cls).remove();
    // });
    //First we remove the icons from default and use a custom ones from fontawesome
    TOOLBAR_ICONS.forEach((icon) => {
      let trix_button = trixToolbar.querySelector(icon["current-icon-class"]);
      trix_button.classList.remove("trix-button--icon");
      trix_button.innerHTML = icon["custom-icon"];
    });
    trixToolbar
      .querySelector(".trix-button--icon-decrease-nesting-level")
      .remove();
    trixToolbar
      .querySelector(".trix-button--icon-increase-nesting-level")
      .remove();
    // document.querySelector(".trix-button-group--file-tools").remove();
  }

  preventFromUpload(event) {
    event.preventDefault();
    alert("File attachment not supported!");
  }
}

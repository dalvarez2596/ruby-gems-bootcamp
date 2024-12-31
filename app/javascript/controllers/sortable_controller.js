import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      ghostClass: "ui-state-highlight",
      handle: "[data-sortable-handle]",
    });
  }
  disconnect() {
    this.sortable.destroy();
  }

  async onEnd(event) {
    const { newIndex, item } = event;
    const itemId = item.dataset;
    const url = itemId.sortableUpdateUrl;
    console.log(newIndex);

    try {
      const response = await fetch(url, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
          Accept: "application/json",
        },
        body: JSON.stringify({
          lesson: {
            row_order_position: newIndex,
          },
        }),
      });
      if (!response.ok) {
        throw new Error("Response not okay");
      }
      console.log("Succesfully updated position");
    } catch (error) {
      console.error("Error updating position");
    }
  }
}

/*
*  Copyright (C) 1998-2022 by Northwoods Software Corporation. All Rights Reserved.
*/

/*
* This is an extension and not part of the main GoJS library.
* Note that the API for this class may change with any version, even point releases.
* If you intend to use an extension in production, you should copy the code to your own source directory.
* Extensions can be found in the GoJS kit under the extensions or extensionsJSM folders.
* See the Extensions intro page (https://gojs.net/latest/intro/extensions.html) for more information.
*/

import * as go from '../release/go.js';

// A "ScrollingTable" Panel

// This also defines an "AutoRepeatButton" Panel,
// which is used by the scrollbar in the "ScrollingTable" Panel.

// This defines a custom "Button" that automatically repeats its click
// action when the user holds down the mouse.
// The first optional argument may be a number indicating the number of milliseconds
// to wait between calls to the click function.  Default is 50.
// The second optional argument may be a number indicating the number of milliseconds
// to delay before starting calls to the click function.  Default is 500.

// Example:
//   $("AutoRepeatButton", 150,  // slower than the default 50 milliseconds between calls
//     {
//       click: (e, button) => doSomething(button.part)
//     },
//     $(go.Shape, "Circle", { width: 8, height: 8 })
//   )
go.GraphObject.defineBuilder('AutoRepeatButton', args => {
  const repeat = go.GraphObject.takeBuilderArgument(args, 50, x => typeof x === "number");
  const delay = go.GraphObject.takeBuilderArgument(args, 500, x => typeof x === "number");
  const $ = go.GraphObject.make;
  // some internal helper functions for auto-repeating
  function delayClicking(e: go.InputEvent, obj: any) {
    endClicking(e, obj);
    if (obj.click) {
      // wait milliseconds before starting clicks
      obj._timer = setTimeout(() => repeatClicking(e, obj), delay);
    }
  }
  function repeatClicking(e: go.InputEvent, obj: any) {
    if (obj._timer) clearTimeout(obj._timer);
    if (obj.click) {
      obj._timer =
        setTimeout(() => {
            if (obj.click) {
              (obj.click)(e, obj);
              repeatClicking(e, obj);
            }
          },
          repeat);  // milliseconds between clicks
    }
  }
  function endClicking(e: go.InputEvent, obj: any) {
    if (obj._timer) {
      clearTimeout(obj._timer);
      obj._timer = undefined;
    }
  }

  const button = $("Button",
           {
             "ButtonBorder.figure": "Rectangle",
             "ButtonBorder.fill": "transparent",
             "ButtonBorder.stroke": null,
             "_buttonFillOver": "rgba(0, 0, 0, .25)",
             "_buttonStrokeOver": null,
             cursor: "auto"
           });
  // override the normal button actions
  const btndown = button.actionDown;
  const btnup = button.actionUp;
  const btncancel = button.actionCancel;
  button.actionDown = function(e, btn) {
    delayClicking(e, btn);
    if (btndown) btndown(e, btn);
  };
  button.actionUp = function(e, btn) {
    endClicking(e, btn);
    if (btnup) btnup(e, btn);
  };
  button.actionCancel = function(e, btn) {
    endClicking(e, btn);
    if (btncancel) btncancel(e, btn);
  };
  return button;
});


// Create a scrolling Table Panel, whose name is given as the optional first argument.
// If not given the name defaults to "TABLE".
// Example use:
//   $("ScrollingTable", "TABLE",
//     new go.Binding("TABLE.itemArray", "someArrayProperty"),
//     ...)
// Note that if you have more than one of these in a Part,
// you'll want to make sure each one has a unique name.
go.GraphObject.defineBuilder("ScrollingTable", args => {
  const $ = go.GraphObject.make;
  const tablename = go.GraphObject.takeBuilderArgument(args, "TABLE");

  // an internal helper function for actually performing a scrolling operation
  // the OBJ may be the "SCROLLBAR" panel or any element within it
  function incrTableIndex(obj: go.GraphObject, i: number) {
    const diagram = obj.diagram;
    let table: go.GraphObject | null = obj;
    while (table && table.name !== "SCROLLBAR") table = table.panel;
    if (table) table = table.panel!.findObject(tablename);
    if (!(table instanceof go.Panel)) return;
    if (i === +Infinity || i === -Infinity) {  // page up or down
      const tabh = table.actualBounds.height;
      const rowh = table.elt(table.topIndex).actualBounds.height;  // assume each row has same height?
      if (i === +Infinity) {
        i = Math.max(1, Math.ceil(tabh / rowh) - 1);
      } else {
        i = -Math.max(1, Math.ceil(tabh / rowh) - 1);
      }
    }
    let idx = table.topIndex + i;
    if (idx >= table.rowCount - 1) idx = table.rowCount - 1;
    if (idx < 0) idx = 0;
    if (table.topIndex !== idx) {
      if (diagram !== null) diagram.startTransaction("scroll");
      table.topIndex = idx;
      const node = table.part;  // may need to reroute links if the table contains any ports
      if (node instanceof go.Node) node.invalidateConnectedLinks();
      updateScrollBar(table);
      if (diagram !== null) diagram.commitTransaction("scroll");
    }
  }

  // must be passed the "Table" Panel that holds the rows that are scrolled
  function updateScrollBar(table: go.Panel) {
    if (table.part) table.part.ensureBounds();
    const bar = table.panel!.findObject("SCROLLBAR");  // the scrollbar is a sibling of the table
    if (!(bar instanceof go.Panel)) return;
    const idx = table.topIndex;

    const up = bar.findObject("UP");
    let uph = 0;
    if (up) {
      up.opacity = (idx > 0) ? 1.0 : 0.3;
      uph = up.actualBounds.height;
    }

    const down = bar.findObject("DOWN");
    let downh = 0;
    if (down) {
      down.opacity = (idx < table.rowCount - 1) ? 1.0 : 0.3;
      downh = down.actualBounds.height;
    }

    const thumb = bar.findObject("THUMB");
    const tabh = bar.actualBounds.height;
    const availh = Math.max(0, (tabh - uph - downh));
    if (table.rowCount <= 0) {
      if (thumb) thumb.height = Math.min(availh, 10);
      return;
    }
    let rows = 0;
    let rowh = 1;
    let last = idx;
    for (let i = idx; i < table.rowCount; i++) {
      const h = table.elt(i).actualBounds.height;
      if (h > 0) { rows++; rowh += h; last = i; }
    }
    const numRows = rowh < tabh ? Math.round(tabh/(rowh/rows)) : rows;
    const needed = idx > 0 || last < table.rowCount-1;
    bar.opacity = needed ? 1.0 : 0.5;
    if (thumb) {
      thumb.height = Math.max(1, Math.min(1, numRows / table.rowCount) * availh);
      thumb.alignment = new go.Spot(0.5, 0, 0, (table.topIndex / table.rowCount) * (availh - thumb.height));
    }
}

  function showScrollButtons(bar: go.GraphObject | null, show: boolean) {
    // may be called with the "SCROLLBAR" panel or any element within it
    while (bar && bar.name !== "SCROLLBAR") bar = bar.panel;
    if (!(bar instanceof go.Panel)) return;
    const table = bar.panel!.findObject(tablename);
    if (!(table instanceof go.Panel)) return;
    const idx = table.topIndex;

    const up = bar.findObject("UP");
    if (up) up.opacity = show ? ((idx > 0) ? 1.0 : 0.3) : 0.0;

    const down = bar.findObject("DOWN");
    if (down) down.opacity = show ? ((idx < table.rowCount - 1) ? 1.0 : 0.3) : 0.0;

    const thumb = bar.findObject("THUMB");
    if (thumb) thumb.opacity = table.rowCount > 0 ? 1 : 0;
  }

  function setScrollIndexLocal(bar: go.GraphObject | null, y: number) {
    // may be called with the "SCROLLBAR" panel or any element within it
    while (bar && bar.name !== "SCROLLBAR") bar = bar.panel;
    if (!(bar instanceof go.Panel)) return;
    const table = bar.panel!.findObject(tablename);
    if (!(table instanceof go.Panel)) return;

    const up = bar.findObject("UP");
    const uph = up ? up.actualBounds.height : 0;

    const down = bar.findObject("DOWN");
    const downh = down ? down.actualBounds.height : 0;

    const tabh = bar.actualBounds.height;
    const idx = Math.round(Math.max(0, Math.min(1, (y - uph) / (tabh - uph - downh))) * table.rowCount);
    incrTableIndex(bar, idx - table.topIndex);
  }

  return $(go.Panel, "Table",
      { // in case external code wants to update the scrollbar
        _updateScrollBar: updateScrollBar
      },
      // this actually holds the item elements
      $(go.Panel, "Table",
        {
          name: tablename,
          column: 0,
          stretch: go.GraphObject.Fill,
          background: "whitesmoke",
          rowSizing: go.RowColumnDefinition.None,
          defaultAlignment: go.Spot.Top
        }),

      // this is the scrollbar
      $(go.RowColumnDefinition,
        { column: 1, sizing: go.RowColumnDefinition.None }),
      $(go.Panel, "Table",
        { name: "SCROLLBAR", column: 1, stretch: go.GraphObject.Vertical, background: "#DDDDDD",
          mouseEnter: (e, bar: go.GraphObject) => showScrollButtons(bar, true),
          mouseLeave: (e, bar: go.GraphObject) => showScrollButtons(bar, false)
        },

        // the scroll up button
        $("AutoRepeatButton",
          { name: "UP", row: 0, opacity: 0,
            click: (e, obj) => { e.handled = true; incrTableIndex(obj, -1); }
          },
          $(go.Shape, "TriangleUp",
            { stroke: null, desiredSize: new go.Size(6, 6) })),
        $(go.RowColumnDefinition, { row: 0, sizing: go.RowColumnDefinition.None }),
        {
          click: (e, bar) => {
            e.handled = true;
            const local = bar.getLocalPoint(e.documentPoint);
            setScrollIndexLocal(bar, local.y);
          }
        },

        // the scroll thumb, gets all available extra height
        $(go.Shape,
          { name: "THUMB", row: 1,
            stretch: go.GraphObject.Horizontal, height: 10,
            margin: new go.Margin(0, 1),
            fill: "gray", stroke: "transparent",
            alignment: go.Spot.Top,
            mouseEnter: (e: go.InputEvent, thumb: go.GraphObject) => (thumb as go.Shape).stroke = "gray",
            mouseLeave: (e: go.InputEvent, thumb: go.GraphObject) => (thumb as go.Shape).stroke = "transparent",
            isActionable: true,
            actionMove: (e: go.InputEvent, thumb: go.GraphObject) => {
              const local = thumb.panel!.getLocalPoint(e.documentPoint);
              setScrollIndexLocal(thumb, local.y);
            },
          }),
        $(go.RowColumnDefinition, { row: 1, stretch: go.GraphObject.Vertical }),

        // the scroll down button
        $("AutoRepeatButton",
          { name: "DOWN", row: 2, opacity: 0,
            click: (e, obj) => { e.handled = true; incrTableIndex(obj, +1); }
          },
          $(go.Shape, "TriangleDown",
            { stroke: null, desiredSize: new go.Size(6, 6) })),
        $(go.RowColumnDefinition, { row: 2, sizing: go.RowColumnDefinition.None }),
      )
    );
});

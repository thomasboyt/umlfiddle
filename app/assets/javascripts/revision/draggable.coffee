$.extend $.fn, 
  splitter: (leftSelector, rightSelector, handleSelector) ->
    lbound = @offset().left
    rbound = lbound + @width()

    $left = @find(leftSelector)
    $right = @find(rightSelector)
    $handle = @find(handleSelector)
    
    dragging = false
    $handle.on "mousedown", (e) =>
      if not dragging
        e.preventDefault()
        dragging = true
    $(document).on "mousemove", (e) =>
      if dragging
        e.preventDefault()
        dragTo(e)
    $(document).on "mouseup", (e) =>
      if dragging
        e.preventDefault()
        dragging = false

    dragTo = (e) =>
      if rbound > e.pageX > lbound
        @trigger("split-resize")
        $left.css("right", (rbound - (e.pageX - lbound)) + "px")
        $handle.css("left", (e.pageX - lbound) + "px")
        $right.css("left", (e.pageX  - lbound) + "px")

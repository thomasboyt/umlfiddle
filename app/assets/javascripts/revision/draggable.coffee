$.extend $.fn, 
  _createSplitBindings: (dragCb) ->
    dragging = false
    @on "mousedown", (e) =>
      if not dragging
        e.preventDefault()
        dragging = true
    $(document).on "mousemove", (e) =>
      if dragging
        e.preventDefault()
        dragCb(e)
    $(document).on "mouseup", (e) =>
      if dragging
        e.preventDefault()
        dragging = false

  vsplit: (leftSelector, rightSelector, handleSelector) ->
    lbound = @offset().left
    rbound = lbound + @width()

    $left = @find(leftSelector)
    $right = @find(rightSelector)
    $handle = @find(handleSelector)

    $handle._createSplitBindings (e) =>
      if rbound > e.pageX > lbound 

        # page edge buffers: if handle is too close to edge, window resize 
        # behavior takes over and splitter can't be resized
        # TODO: test in diff browsers/os's - 5 may not be enough
        if $(document).width() - e.pageX < 5
          e.pageX = $(document).width() - 5
        if e.pageX < 5
          e.pageX = 5

        @trigger("split-resize")
        $left.css("right", (rbound - (e.pageX - lbound)) + "px")
        $handle.css("left", (e.pageX - lbound) + "px")
        $right.css("left", (e.pageX - lbound) + "px")

  hsplit: (topSelector, bottomSelector, handleSelector) ->
    tbound = @offset().top
    bbound = tbound + @height()

    $top = @find(topSelector)
    $bottom = @find(bottomSelector)
    $handle = @find(handleSelector)

    $handle._createSplitBindings (e) =>
      if bbound > e.pageY > tbound
        @trigger("split-resize")
        $top.css("bottom", (bbound - (e.pageY - tbound)) + "px")
        $handle.css("top", (e.pageY - tbound) + "px")
        $right.css("top", (e.pageY - tbound) + "px")

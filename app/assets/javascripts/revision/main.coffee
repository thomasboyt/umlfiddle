$ =>
  editor = ace.edit $(".editor")[0] 
  editor.getSession().setUseWrapMode(true);
  $(".editor").css("visibility", "visible")

  editor.getSession().on('change', _.debounce(((e) =>
    newValue = editor.getValue()
    try
      diagram = Diagram.parse(newValue)
      $(".diagram").html("")
      diagram.drawSVG($(".diagram").get(0))
      editor.getSession().clearAnnotations()
    catch error
      editor.getSession().setAnnotations [{
        row: error.line
        column: 1
        text: "Parsing error."
        type: "error"
      }]
  ), 600))

  $("#save").click((e) =>
    # this is kinda goofy, but better than getting id from rails
    match = window.location.pathname.match(/(.+\/v\/)/)
    if match
      retLocation = (data) => match[0] + data.num
    else
      # if not on a :id/v/:num path, must be a new item
      retLocation = (data) => "/fiddles" + data._id + "/v/1"

    $.post(postUrl, {
      content: editor.getValue()
    }, (data) =>
      window.location = retLocation data
    )
  )

$(".diagram").sequenceDiagram({theme: "hand"})
$(".diagram").css("visibility", "visible")

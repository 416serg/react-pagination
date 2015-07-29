paginationBar = (pwindow, total, current) ->
  middle = Math.ceil(pwindow/2)
  ini = current - middle
  end = current + middle
  if ini < 0
    ini = 0
    if total > pwindow
      end = pwindow
    else
      end = total
  else if end >= total
    end = total
    ini = end - pwindow
    if ini < 0 then ini = 0

  [ini...end]

ReactPagination = {}

ReactPagination.Pagination = React.createClass
    mixins : [ReactMeteorData]
    getMeteorData: ->
        pages: (count) =>
            current = parseInt(FlowRouter.getQueryParam('page')) or 0
            total = Math.ceil(Counts.get(count)/@props.itemsPerPage)
            paginationBar(@props.window, total, current)
        selected: (pos) ->
            current = parseInt(FlowRouter.getQueryParam('page')) or 0
            if parseInt(pos) == current then 'page-selected' else ''
        showMinus: ->
            current = parseInt(FlowRouter.getQueryParam('page')) or 0
            current != 0
        showPlus: (count) =>
            current = parseInt(FlowRouter.getQueryParam('page')) or 0
            total = Math.ceil(Counts.get(count)/@props.itemsPerPage)
            all = paginationBar(@props.window, total, current)
            current != all[-1..][0]
    pageClick: (page) -> (event) ->
        FlowRouter.setQueryParams page: page
    firstClick: ->
        FlowRouter.setQueryParams({page: 0})
    lastClick: ->
        total = Math.ceil(Counts.get(@props.count)/@props.itemsPerPage)
        FlowRouter.setQueryParams({page: total-1})
    plusClick: ->
        page = parseInt(FlowRouter.getQueryParam('page')) or 0
        FlowRouter.setQueryParams page: page + 1
    minusClick: ->
        page = parseInt(FlowRouter.getQueryParam('page')) or 0
        FlowRouter.setQueryParams page: page - 1
    render: ->
        <span>
        {if @data.showMinus()
            <span>
                <span onClick=@firstClick className="first-button first">&lt;&lt;</span>
                <span onClick=@minusClick className="minus-button minus">-</span>
            </span>
        }
        {for p, i in @data.pages @props.count
            <span onClick=@pageClick(i) page=p className={"page-button change-page " + @data.selected(i)}>{i+1}</span>
        }
        {if @data.showPlus @props.count
            <span>
                <span onClick=@plusClick className="plus-button plus">+</span>
                <span onClick=@lastClick className="last-button last">&gt;&gt;</span>
            </span>
        }
        </span>


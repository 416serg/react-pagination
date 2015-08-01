react-pagination
================

A simple pagination widget for React and FlowRouter.

Example
-------

You must install ```kadira:flow-router``` and ```tmeasday:publish-counts```.

```coffee
@limit = 2

@Demo = React.createClass
    mixins : [ReactMeteorData]
    getMeteorData: ->
        posts: posts.find({}, {limit: limit, sort: {createdAt: 1}}).fetch()
    render: ->
        <div>
            {for post in @data.posts
                <div>
                    <h2>{post.title}</h2>
                    <em>{moment(post.createdAt).format('DD-MM-YYYY')}</em>
                </div>
            }
            <ReactPagination.Pagination itemsPerPage=limit window=5  count='total_posts' />
        </div>
        
FlowRouter.route '/',
  name: 'home'
  subscriptions: (params, queryParams) ->
      page = parseInt(queryParams.page) or 0
      offset = page*limit
      this.register('postsWithSkip', Meteor.subscribe('postsWithSkip', offset, limit))
  action: (params, queryParams) ->
    Template.body.onRendered ->
      React.render <Demo />, document.getElementById('yield')        
```
      
```css
.page-selected {
    text-decoration: underline;
}

.first-button, .minus-button, .page-button, .plus-button, .last-button {
    cursor: pointer;
}
```
      
server side:
```coffee
Meteor.publish 'postsWithSkip', (skip, limit) ->
  Counts.publish(this, 'total_posts', posts.find())
  if skip < 0 then skip = 0
  options = {}
  options.skip = skip
  options.limit = limit
  if options.limit > 10 then options.limit = 10
  options.sort = {createdAt: 1}
  posts.find({}, options)
```  
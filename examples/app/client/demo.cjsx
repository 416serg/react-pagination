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
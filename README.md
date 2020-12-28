# ThisIsBudTest

## Test

### Definition:

The test is about creating a simple app that can display to the user a list of transactions.
Each transaction is detailed as follow:
  . Description of the transaction
  . Category of the transaction
  . Value of the transaction
  . Currency symbol of the transaction
  . A logo of the transaction
  
The user should have the ability to remove x amount of transactions upon tapping on the `edit`
button which is situated on the top right of the screen, selecting x amount of transaction by
tapping on each one of them (thus highlighting them in red) and tapping on the `remove` button
situated at the bottom of the screen. The `edit` button turns into a `done` button once in edit
mode, assumption made that the `done` button allows to quit the edit mode without validating any
unconfirmed changes (transactions selected but not deleted). The `remove` button only appears on
edit mode.

### Approach:

I decided to treat this as simply as possible, inferring possible future changes but without taking
it too far.
I went for a simple MVC, with a root coordinator pushing the root view controller. Though there is
currently no flow this allows us to prepare for any new view controller that could be pushed
(i.e: pushing a transaction detail view controller).
For the endpoint I created a very simple generic API handler with a decorator handler for transactions
requests. The transaction handler handles the data to object using the codable protocol to parse each
response.
Empty placeholder request for remove has been implemented too, though it does nothing more than print
at the moment, since the endpoint is not dynamic.

The core test was done in ~2 hours, implementation of styles protocols were not developed during this test
time frame, they were developed by me to serve as a basis for my personal projects out of this test's scope.

Once a request has finished, it notifies the view controller holding the transaction table view, providing
the new data, the table view can then update to reflect the changes.

The items mainly used for this test are:
  - The root coordinator
  - The root view controller - table view and root cell
  - The API handler
  - The transaction handler

### UI:

The app is heavily based on protocols and items definitions to normalize the UI accross the entire app.
Style is defined in one place and applied to all the view controllers and views as well as child
view controllers and child views through recursion.
This might look like a lot of code, but it allows to uniformize the UI definition and get rid of magic
numbers and inconsistencies, also, it wouldn't grow consistently the more view controllers / components
we add.

These protocols, definitions and classes were not created during this test's time scope, but were patterns
I usually keep on the side for personal projects, as a basis. They're not full either as usually test don't require to
cover it all, so I integrate only the needed patterns.

### Testing:

Very basic unit testing and UI testing were implemented just to showcase that I do know what they are and
how they work, also, coverage is not ideal but again, the idea was to try to do the test in the time specified
during the interview, which is roughly ~2hrs.

### Known issues:

  - Deletion since not integrated on endpoint side, is only done locally, meaning that refreshing the transactions
  through a `get` would automatically reset any changes made by the user.
  - Populating the table view through requests is currently not made in a paginated way, since the endpoint
  is pretty much static, but that's something that can easily be updated if ever needed.
  - Caching is only used for images so far, since those were the most heavy-weight components.
  - Table view is not entirely using it full potential (also related to pagination), since only one section is implemented
  and we're not using inserts and delete but instead reloading the entire view for now.
  It didn't make sense to implement it without the pagination and within the limit of time for this test.

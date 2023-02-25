# README

So, you wanna be a Ruby on Rails back end engineer, huh?? Then you came to the right place. 👊🙂

As of the posting of this article, I am finishing up my fourth phase of Flatiron School's full-stack software engineering boot camp. Phase 4 was focused on the topic of this article: Ruby on Rails. As an abstraction of Ruby, Rails expedites many of the tasks necessary to set up a Ruby database. What's the best way to do this, you ask? Well, let's find out! But first, let me briefly outline the data examples to best illustrate how our back end is built.

I'm a big music fan, and a full album listener at that, so I'd like to use the example of **music fans** giving **ratings** to particular **albums**. Each **music fan** can rate many different **albums**, and each **album** can be rated by many different **music fans**. It would make sense to have each **music fan** to only be able to rate each **album** once, because otherwise it would get confusing. Lastly, each **rating** will belong to one **music fan** and one **album**, so **ratings** will act as our _join table_ with a _foreign key_ for each of the other tables named **music fans** & **albums**.

So, each of our tables will have these attributes/columns:

- **Music Fans** - _:name_
- **Albums** - _:title, :artist, :release_year_
- **Ratings** - _:score, :music_fan_id, :album_id_

Creating our associations will come into play later on, but now that we know what data we're going to be working with, let's review our Rails resources...

# Rails Resources

In a Ruby on Rails application, there are a few essential things to keep an eye on at the highest level of our file hierarchy:

- **Gemfile** _(list of gems to install)_
- **db/** _(database folder)_
- **config/** _(configurations folder)_
- **app/** _(application folder)_

If you are in the habit of paying attention to these files and folders, then you won't be caught off guard by any of the basic issues with building out your Rails back end!

We do have a single terminal command that will build out all of the aforementioned resources for us, in the form of:

```
rails g resource class_name attribute_name:attribute_type
```

...BUT, it's really important to understand all of the things that this command is doing, and how to properly write the command based on your particular dataset. So, let's start from the top.

## Let's Break it Down by Each Resource...

### Gemfile

As mentioned above, this is where we list our gems to be installed - these are our Ruby tools that make our life easier when building this code. For our purposes, we want to make sure our gemfile includes:

```ruby
gem "active_model_serializers", "~> 0.10.12"
```

...and then to install these gems for use in development and testing, we enter this in our terminal:

```
bundle install
```

_**NOTE:** All of your other needed gems should be included if you properly created your rails application with:_

```
rails my_music_app
```

After creating our app's file structure and installing our gems, we can move on and start building out our data structure.

### Database Folder - _db/_

Now the fun begins. Our database folder is going to contain **FOUR important things:**

1. **db/migrate** (migrations folder)
2. **schema.rb** (database structure file, based on migrations)
3. **seeds.rb** (seed data, formatted for schema.rb)
4. **development.sqlite3** (final rendered database file)

Let's break it down...

#### 1. db/migrate - _(migrations)_

This is the folder is where it all begins. Our migration files set up the data structure for each of our tables, including both the name of the table itself and the labels for each column attribute. Each table will have its own migrations. For our **Ratings** table (the join table with foreign keys), this is what our initial migration file would look like if we built it manually _(but hold off on this for just a minute)_:

```ruby
class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :score
      t.integer :music_fan_id
      t.integer :album_id
    end
  end
end
```

#### 2. schema.rb - _(database structure)_

Our schema file will act as the data structure resulting from the migrations for all of our tables, acting as a filter for our incoming seed data. This file will look similar to our migrations, but will include all the tables. To create our schema file manually _(again, hold off on this too unless you want practice)_, we need to run this in our terminal:

```
rails db:migrate
```

Our resultant file should look something like this, including all three of our table migration structures:

```ruby
ActiveRecord::Schema.define(version: 2023_01_20_164246) do
  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.integer "release_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "music_fans", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.integer "music_fan_id", null: false
    t.integer "album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
```

It's always good to double check your schema file after performing _rails db:migrate_, just to make sure things are looking accurate. So, now our data structure is in place for us to seed our data tables with. BUT, we can't seed our data without...

#### 3. seeds.rb _(our seed data)_

This is the file in which we set up the actual data values for our table to be populated with. Without our seeds file, we won't be able to utilize our schema, because it won't have anything to work with. Basically, without a functioning seeds file, our resulting database will be comprised of empty tables. We don't want that, so let's look at what we need to do to build our seed data.

There are many Ruby methods we can use in building our seeds file, but we will keep it simple this time. If we were to seed with 3 instances each of _music_fan_ and _album_, along with 6 unique _rating_ instances, this is what it might look like:

```ruby
puts "🎵 Seeding music fans..."
MusicFan.create(name: "Vizmund Cygnus")
MusicFan.create(name: "Cassandra Gemini")
MusicFan.create(name: "Cerpin Taxt")

puts "🎵 Seeding albums..."
Album.create(
  title: "DAMN. COLLECTORS EDITION.",
  artist: "Kendrick Lamar",
  release_year: 2017
)
Album.create(
  title: "In Rainbows",
  artist: "Radiohead",
  release_year: 2007
)
Album.create(
  title: "Monsters Are People",
  artist: "Chess at Breakfast",
  release_year: 2021
)

puts "🎵 Seeding ratings..."
Rating.create(score: 10, music_fan_id: 1, album_id: 2)
Rating.create(score: 9, music_fan_id: 3, album_id: 1)
Rating.create(score: 8, music_fan_id: 2, album_id: 3)
Rating.create(score: 7, music_fan_id: 3, album_id: 3)
Rating.create(score: 6, music_fan_id: 2, album_id: 2)
Rating.create(score: 5, music_fan_id: 1, album_id: 1)

puts "Done seeding!"
```

_PRO TIP: If you want to get practice using the Faker Gem to automate some of the details of your seeds file, _

As you can see, our seed data is built using pretty basic Ruby object format, with keys corresponding to our table attributes and unique values for those keys in each new creation of an instance. And luckily, we don't need to hold off creating this seeds file, since we will always have to create it manually.

_NOTE: Each creation of an instance assigns **id** based on the order in which they're built, so the first MusicFan (Vizmund Cygnus) will have an **id** of 1, and the second (Cassandra Gemini) will have an **id** of 2, and so on..._

With our fleshed-out seed data now created, we should be in a position to seed and render our database.

#### 4. db.sqlite3 - _(rendered database)_

Assuming our seed data and migrations are formatted correctly, we can now run this command in our terminal:

```
rails db:seed
```

Once we seed, we should now have a _development.sqlite3_ file in our _db/_ folder. Right-click on this and select "Open Database". This will open up your SQLite Explorer in the bottom-left corner of your VS Code window. _**NOTE:** Make sure you've installed SQLite as an extension in VS Code, or this won't work!_

If you've done everything correctly up to this point, you should have three tables. For example, your **albums** table should look like this:

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/kt7jqjz3alpe6sdu4fne.PNG)

If there are ever any weird issues with the database throughout development, you can always try this command:

```
rails db:reset
```

...which will drop the database (make sure you actually want to drop it before you do this!) and re-seed.

Now that we have a rendered database, we can _finally_ move on to **USING** our data!

### Configurations Folder - _config/_

Our config folder luckily only has one file we need to keep a close eye on: _routes.rb_

This file is where we can determine what CRUD actions to be allowed for our different controllers, as well as setting up custom routes for things like user authentication. We won't take a super close look at this here, but here's what our basic routes file would look like if we have full CRUD on albums and music fans, but only index, show, create, and destroy (excluding update) on our ratings:

```ruby
Rails.application.routes.draw do
  resources :ratings, only: [:index, :show, :create, :destroy]
  resources :music_fans
  resources :albums
end
```

Doing this will ensure that we don't have any unused routes on our back end, which will speed up our rendering process.

Now that we have limited our routes, to enhance efficiency, we can move on to our final resource...

### Application Folder - _app/_

Similar to how I went over the config folder, I won't go into too much detail on our app folder, but I will give an overview of the important resources to keep an eye on, along with why. Here's a brief list:

1. **models** (foundational class models)
2. **controllers** (controllers with route actions)
3. **serializers** (serializers for preparing data output)

#### app/models - _class models_

Our models are the foundation for the rest of our app folder, because it's where we determine our associations and our validations. First and foremost, we need to build out our associations. Here's how they will look, with a score validation between 1-10:

_rating.rb_
```ruby
class Rating < ApplicationRecord
  belongs_to :music_fan
  belongs_to :album

  validates :score, inclusion: 1..10
end
```

_music_fan.rb_
```ruby
class MusicFan < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :albums, through: :ratings
end
```

_album.rb_
```ruby
class Album < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :music_fans, through: :ratings
end
```

_NOTE: Our Rating model will already have the belongs_to relationships if we use rails g resource properly. Stick around to the end to see how that's written._

_OTHER NOTE: We include **dependent: :destroy** in order to engage the destroy route of all ratings associated with a particular music fan or album, when they themselves are destroyed. This makes sense because ratings without music fans or albums shouldn't technically exist and will cause issues with rendering in the front end._

Awesome! Now we can move on to our next application resource.

#### app/controllers - _with route actions_

Our controllers will contain the methods that our _routes.rb_ file points to. As far as full CRUD, the default actions are as follows:

- index _(READ all)_
- show _(READ one)_
- create _(CREATE one)_
- update _(UPDATE one)_
- destroy _(DELETE one)_

To demonstrate full CRUD here, we need to pick one of the models that has full CRUD. For this purpose, let's go with albums:

```ruby
class AlbumsController < ApplicationController

  def index
    albums = Album.all
    render json: albums, status: :ok
  end

  def show
    album = Album.find(params[:id])
    render json: album, status: :ok
  end

  def create
    album = Album.create!(album_params)
    render json: album, status: :created
  end

  def update
    album = Album.find(params[:id])
    album.update!(album_params)
    render json: album, status: :accepted
  end

  def delete
    album = Album.find(params[:id])
    album.destroy
    head :no_content
  end

  private
  
  def album_params
    params.permit(:title, :artist, :release_year)
  end
  
end
```

_**NOTE:** we save ourselves a bit of time by defining **album_params** in our **private methods**._

We now have all of our CRUD methods built for albums, so all our routes should work properly for it. We can now move on to the final piece in the puzzle...

#### app/serializers - _for preparing data output_

We're almost there! With serializers, we are basically telling our routes how to prepare our data. So let's say that when we fetch a particular album, we want to also show all the music fans that have rated that particular album. To do this, we simply need to add one line to our _album_serializer.rb_. Here's what the file will look like:

```ruby
class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :release_year
  has_many :music_fans
end
```

This will ensure that when we do fetch that album, the JSON response will have a _music_fans_ key and a corresponding value of an array nesting all the music fans that have rated the album.

_**NOTE:** We don't need to include the **through: :ratings** here because we have already established that association in our model._

One cool element to serializers is that you can create your own custom ones if you need to have more specific data outputs for particular CRUD actions. I won't go into that here, but I recommend doing some research on it!

Now that we've established the importance of all our resources, we  can tie it all together.

## Tying it All Together

Jeez. Rails has a **LOT** of resources to keep track of, eh?? If we had to populate our back end with all of these resources one at a time, it would take awhile for sure. Luckily, we don't have to!

### Generators to the Rescue

Rails has a generator feature that will create all of these files for us. However, there is room for error here, so it's very important to understand all the resources that are created by the generator, and how to check these resources for errors. Let's take a look at what the generator commands for each class will look like in our terminal, and then break them down. First, here is the basic formula, as mentioned at the beginning of this article:

```
rails g resource class_name attribute_name:attribute_type --no-test-framework
```

_**NOTE:** Include **--no-test-framework** if you already have testing files and want to avoid overwriting them._

And now our specific class examples:

_Rating_
```
rails g resource rating score:integer music_fan:belongs_to
```

_MusicFan_
```
rails g resource music_fan name
```

_Album_
```
rails g resource album title artist 
```

_**NOTE:** The default **attribute_type** is **string**, so unless a particular attribute is something else, such as integer, you don't need to actually include the type in your resource generator._

_**OTHER NOTE:** As far as associations, we can only include **belongs_to** in our resource generator, and need to manually create our **has_many** associations later on in our individual models._

As you see upon execution in your terminal, this command creates ALL of the resources we have gone over in this article. Pretty cool! If you did this command the right way, you're well on your way to customizing your back end.

I hope this article was helpful, and as always...

## Happy Coding!
## CatCMS

_**C**ool **A**r**t** **C**ontent **M**anagement **S**ystem_

The typical website a visual artist uses to display their work is both expensive to buy and expensive to maintain. CatCMS was born from the desire to create a simple and powerful tool that empowers an artist to both create and maintain their own website.

This tool can be used to build any simple website without the developer needing to upload any code and without the user needing to know how the website works behind the scenes. Once an instance of CatCMS has been deployed to a server, the developer is entirely hands-off, and the user can take control of the website creation and maintenance.

## Features

- You can create, edit, and delete pages
- You can change the website title and content
- You can populate image galleries and blogs
- You can change the website appearance without writing code

## Tech Stack

<b>Frontend</b>

- [jQuery](https://jquery.com/)
- [Bootstrap](https://getbootstrap.com/)

<b>Backend</b>

- [Ruby on Rails](https://rubyonrails.org/)
- [SQLite](https://www.sqlite.org/index.html)

## Development

- [Install Ruby 2.7.0, Rails 5.2.4.4, and Node.js](https://gorails.com/setup)
- `sudo apt-get install -y imagemagick libmagickwand-dev`
- `gem install bundler:2.1.4`
- `bundle`
- `rails db:setup`
- `rails s`

## Deployment

- Install Docker and Docker Compose
- [CatDocker](https://github.com/dyersituations/catdocker)
- [Digital Ocean](https://www.digitalocean.com/)
  - $5 Ubuntu Droplet

## License

MIT © [Casey Dyer](https://github.com/dyersituations)

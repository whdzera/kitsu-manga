# Kitsu Manga

Kitsu Manga is a web reading manga written in Ruby on Rails, featuring a clean interface and seamless reading experience.

## View

<img src="https://i.imgur.com/6Ku0dpI.png" width="80%">

<img src="https://i.imgur.com/jrRGFmr.png" width="80%">

<img src="https://i.imgur.com/SilPtHy.png" width="80%">

<img src="https://i.imgur.com/xtxcd8w.png" width="80%">

## Features

- login/regist (auth with Devise)
- Rest APIs (auth with Devise-JWT)
- login/regist anti bot (with ReCaptcha)
- Email confirmation register (with Action Mailer)
- Pagination (with Kaminari)
- Role Users (Admin and Member)
- Profile users (About, Rencet fav manga, etc)
- Admin dashboard (User Moderation, Manga managements, reports, etc)
- Rss Feed (Newly Updated Manga Chapters)
- Bookmarks (for users role member)
- Comments (for users role admin,member)

### Tech Stack

- Ruby on Rails, Stimulusjs, Bulma

### Prerequisites

- Ruby (3.3.0)
- Rails (8.0.1)

### Setup

1. Clone this repository:
   ```sh
   git clone https://github.com/whdzera/kitsu-manga.git
   cd kitsu-manga
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Setup the database:
   ```sh
   rails db:setup
   ```
4. Start the Rails server:
   ```sh
   rails server
   ```

## Developer Tool

Run Rails Development mode:
   ```sh
   rake dev
   ```

Run Unit Test:
   ```sh
   rake test
   ```

## Contributing

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Make your changes and commit them: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Create a pull request.

## Gists

- [Automation increase chapter in kitsumanga](https://gist.github.com/whdzera/b99aa5c9d2d779a52ae4e2fc9b132e99)

## License

`Do not deploy on a public server without my permission`

This project is licensed under the Apache License.

## Contact

For any questions or suggestions, feel free to open an issue on GitHub.

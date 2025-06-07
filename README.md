# Kitsu Manga

Kitsu Manga is a web reading manga written in Ruby on Rails, featuring a clean interface and seamless reading experience.

## View

<img src="https://i.imgur.com/kqbWq4O.png" width="80%">

<img src="https://i.imgur.com/HrQfMMH.png" width="80%">

<img src="https://i.imgur.com/KibV3kz.png" width="80%">

## Features

- UI Semi Transparent with Bulma
- login/regist Auth with Devise
- login/regist Anti bot with Hcaptcha
- Email Confirmation Register with Action Mailer
- Pagination with Kaminari
- Role: Admin, Member, Guest
- Admin dashboard: User manag, reports, etc
- Profile Users: About, Rencet fav manga,etc
- Bookmarks Manga System
- Comments system


## Tech Stack

- Ruby on Rails (Backend)
- SQLite (Database) for development, can be switched to MySQL or PostgreSQL
- Bulma and Font-awesome (Styling and icon)
- Stimulus and Turbo (Interactive)

### Prerequisites

- Ruby (3.3.0)
- Rails (8.0.1)
- ImageMagick (6.9.11)

### Setup

1. Clone this repository:
   ```sh
   git clone https://github.com/rokhimin/kitsu-manga.git
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
5. Open `http://localhost:3000` in your browser.

## Contributing

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Make your changes and commit them: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Create a pull request.

## Gists

- [Automation increase chapter in kitsumanga](https://gist.github.com/rokhimin/b99aa5c9d2d779a52ae4e2fc9b132e99)

## License

This project is licensed under the Apache License.

## Contact

For any questions or suggestions, feel free to open an issue on GitHub.
.

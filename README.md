# Kitsu Manga

Kitsu Manga is a web reading manga written in Ruby on Rails, featuring a clean interface and seamless reading experience.

## Tech Stack
- Rails
- Sqlite
- Bulma & Font-awesome
- Turbo & Stimulus

## Features

- login/regist Auth with Devise
- hcaptcha before login/regist
- Email Confirmation Register with Action Mailer
- UI Semi Transparent with Bulma css
- Pagination with Kaminari
- Have role member and admin (guest user can read manga)
- etc

## View
<img src="https://i.imgur.com/rKz4ei3.png" width="80%">

<img src="https://i.imgur.com/hIJYl8U.png" width="80%">

<img src="https://i.imgur.com/tjbW7c0.png" width="80%">

### Prerequisites
- Ruby (3.3.0)
- Rails (8.0.1)

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
   rails db:migrate
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

## License

This project is licensed under the MIT License.

## Contact

For any questions or suggestions, feel free to open an issue on GitHub.


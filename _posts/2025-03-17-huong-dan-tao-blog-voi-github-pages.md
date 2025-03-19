---
title: "Hướng dẫn tạo một Blog với GitHub Pages"
date: 2025-03-17 23:55:00 +0700
categories: [Jekyll]
tags: [Jekyll, GitHubPages]
---

Bạn đang có ý định tạo một **Blog** nhầm chia sẽ kiến thức, hiện nay có khá nhiều nền tảng hỗ trợ người dùng xây dựng một **Blog** như: WordPress, Blogspot, Medium, ... Trong bài viết này, tôi xin giới thiệu thêm một nền tảng hoàn toàn miễn phí nữa đó là **GitHub Pages** kết hợp với **Jekyll**.

**Let's go** 🏃🏻‍➡️

## GitHub Pages là gì?

**GitHub Pages** là một dịch vụ miễn phí của GitHub, giúp bạn host trực tiếp các trang web tĩnh từ repository.

**GiHub Pages** hỗ trợ sẵn các Actions để tự động build và deploy khi bạn push một commit mới lên repository.

Ngoài ra, **Github Pages** đã được tích hợp **Jekyll**, **Markdown** và các theme có sẵn để bạn viết và đăng bài vô cùng dễ dàng.

---

## Jekyll là gì?

**Jekyll** là một **Static Site Generator** (trình tạo trang tĩnh) được viết bằng  Ruby. Giúp bạn chuyển đổi plain text vào trong static website và blog mà không cần Backend.

**Jekyll** hỗ trợ **Markdown**, **Liquid** (template engine), **SCSS**.

**Jekyll** hỗ trợ rất nhiều theme và tuỳ chỉnh giao diện dễ dàng.

---

## Tạo một Blog

### Clone/Fork theme và cấu hình ứng dụng

Bạn có thể xem cách tạo mới một **Jekyll** site [tại đây](https://jekyllrb.com/docs/).

Cá nhân tôi thì Fork theme [chirpy-starter](https://github.com/cotes2020/chirpy-starter) bằng cách click vào button `Use this template` sau đó chọn `Create a new repository`.

### Host một website từ repository bằng GitHubPages

Như đã trình bày bên trên, bây giờ chúng ta sẽ thực hiện host một website từ repository sử dụng nền tảng GitHub Pages như sau:

- **Bước 1:** Trước tiên mở trình duyệt và truy cập đến [GitHub](http://github.com).
- **Bước 2:** Chọn repository có sẵn hoặc bạn vừa clone/fork bên trên.
- **Bước 3:** Chọn tab `Settings` -> `Pages`.
- **Bước 4:** Tại phần `Build and deployment`. Bạn cần thực hiện như sau:
  - **Source**: Option này tôi lựa chọn `Deploy from a branch`, để Actions tự động build và deploy lại khi bạn push một commit mới lên. Nếu muốn custom Actions thì bạn cần chọn option `GitHub Actions`.
  - **Branch**: Option này bạn cần chỉ ra branch và thư mục để deployment.
  - **Save**: Lưu lại cấu hình và kích hoạt quá trình `Build and deployment`

Hình ảnh sau khi hoàn thành cấu hình **GitHub Pages**.
![settings-github-pages](../assets/img/posts/2025-03-17-huong-dan-tao-blog-voi-github-pages/settings-github-pages.png)

### Kiểm tra Actions

Để kiểm tra trạng thái của Actions thì bạn chọn tab `Actions`. Bạn sẽ thấy danh sách worker runs, click vào một item để kiểm tra tình trạng, cũng như lỗi nếu có.

Trong trường hợp không có lỗi xãy ra thì bạn đã build thành công một Blog trên GitHub Pages rồi đó. 

❓ Thế thì ở đây sẽ có một câu hỏi lớn đặt ra là chúng ta có cần cài đặt thêm  **Jekyll**? 🤔

✅ Chúng ta không cần cài đặt thêm **Jeykyll** để có thể viết blog. Nhưng sử dụng thêm **Jekyll** sẽ mang lại nhiều lợi ít cho việc trực quang hoá nội dung bài viết trước khi chúng được deploy lên **Github Pages**. Log lỗi nếu bạn cấu hình sai. Ngoài ra còn hỗ trợ bạn chỉnh sửa gem theme mặc định nếu muốn, v/v ... 

### Cài đặt Jekyll chạy trên Docker

Trong phạm vi bài viết này tôi sẽ hướng dẫn bạn cài đặt **Jekyll** chạy trên **Docker**. Trong trường hợp bạn muốn cài trực tiếp trên máy local thì xem hướng dẫn [tại đây](https://jekyllrb.com/docs/installation/)

#### Tạo một `Dockerfile`

Bạn cần tạo một `Dockerfile` và copy nội dung bên dưới vào, hoặc bạn có thể pull từ **DockerHub** theo lệnh `docker pull thehappycode/jekyll-blog`

```docker
# syntax=docker/dockerfile:1
FROM ubuntu:24.04

# "Get the latest APT packages"
RUN apt-get update

# "Cài đặt Ruby và các gói yêu cầu khác
RUN apt-get -y install \
    git \
    ruby-full \
    build-essential \
    zlib1g-dev

# " Cấu hình gem PATH
RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
RUN bash -c "source ~/.bashrc"

# "Cài đặt Jekyll và Bundler
RUN gem install jekyll bundler

# "Tạo WORKDIR
WORKDIR /app

# COPY source code vào /app trong container
COPY . /app

# Bundle install các dependencies
RUN bundler install

# Mở port 4000
EXPOSE 4000

# Chạy Jekyll khi khởi động container
CMD ["bundle", "exec", "jekyll", "serve", "--livereload", "--trace", "--host", "0.0.0.0"]

```

#### Tạo một `image`

Mở Terminal và di chuyển đến thư mục chứa `Dockerfile` sau đó chạy sau để build một image.

```docker
docker build -t jekyll-blog . 
```
#### Tạo một `container`

Mở Terminal và di chuyển đến thư mục chứa repository, sau đó chạy lệnh sau để tạo một container.

- Trường hợp bạn pull image từ DockerHub 
```docker
% docker run --name blog -dp 127.0.0.1:4000:4000 --mount type=bind,src=.,target=/app thehappycode/jekyll-blog
```

- Trường hợp bạn build image
```docker
docker run --name blog -dp 127.0.0.1:4000:4000 --mount type=bind,src=.,target=/app jekyll-blog
```

#### Tạo Jekyll Watch

`jekyll-watch` giúp chúng ta tự động rebuilding server khi phát hiện có môt file bị thay đổi.

Tạo một file Ruby có tên `jekyll-watch.rb` trong thư mục `./_plugins`. Sau đó copy nội dung sau vào file:

```ruby
module Jekyll
  class WatcherLogger < Jekyll::Plugin
    def self.post_read(site)
      Jekyll.logger.info "👀 Jekyll Watch:", "Đã phát hiện thay đổi file! Rebuilding..."
    end
  end

  Hooks.register :site, :post_read do |site|
    WatcherLogger.post_read(site)
  end
end
```

### Chỉnh sửa file `_config.yml`

`_config.yml` là file chứa tập hợp những cấu hình cần thiết dành cho **Jekyll**. Bạn có thể mở file và thay đổi hoặc thêm mới một số thông tin sau:
- `lang`: Ngôn ngữ của website. Mặc định là tiếng Anh.
- `timezone`: Múi giờ.
- `title`: Tiêu đề của website.
- `tagline`: Tương tự như Slogan - khẩu hiệu.
- `url`: Protocal & hosname dành cho website của bạn.
- `baseUrl`: Base Url website của bạn.
- `avatar`: Ảnh đại diện.
- `email`: Email

Bạn có thể cấu hình thêm các thông tin như github, các mạng xã hội như: Facebook, Twitter, ...

### Thay đổi **favicon**

Copy favicon vào thư mục **/assets/img/favicons** để thay thế icons mặc định. Trường hợp chưa có favicon thì làm theo hướng dẫn bên dưới.

#### Tạo favicon

Truy cập vào [Real Favicon Generator](https://realfavicongenerator.net/), upload hình ảnh để tạo favicon.

#### Download & Replace

Download, giải nén gói favicon đã tạo. Sau đó xoá 2 file sau:
- browserconfig.xml
- site.webmanifest

Copy tất cả các file còn lại vào trong thư mục **/assets/img/favicons**

### Thay đổi Stylesheet

Trường hợp bạn muốn thay đổi stylesheet, thêm mới file **assets/css/jekyll-theme-chirpy.scss**. Copy [nội dung](https://github.com/cotes2020/jekyll-theme-chirpy/blob/master/assets/css/jekyll-theme-chirpy.scss) vào file sau đó thêm những thay đổi stylesheet tại dòng cuối cùng.

### Kiểm tra thành quả 

Chúng ta sẽ kiểm tra thành quả bằng viết Blog đầu tiên `2025-03-16-hello-world.md`

```md
---
title: "Hello World"
date: 2025-03-16 02:20:00 +0700
categories: [Jekyll]
tags: [Jekyll]
---

# Hello World

Hello World this my personal blog.
Test jekyll-watch => Good job
```

Hình ảnh sau khi hoàn thành bài post
![hello-world](../assets/img/posts/2025-03-17-huong-dan-tao-blog-voi-github-pages/hello-world.png)
---

## Chúc mừng
Xin chúc mừng bạn đã hoàn thành tạo một **Blog**. Rất vui và hạnh phúc khi bạn đọc hết blog này. Mong bạn có nhiều bài viết hữu ít chia sẽ kiến thức cho cộng động.

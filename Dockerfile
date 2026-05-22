# Stage 1: Download static ffmpeg binary via Alpine (has apk)
FROM alpine:3.19 AS ffmpeg-downloader
RUN apk add --no-cache wget xz \
  && wget -q https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    && tar -xJf ffmpeg-release-amd64-static.tar.xz \
      && cp ffmpeg-*-amd64-static/ffmpeg /usr/local/bin/ \
        && cp ffmpeg-*-amd64-static/ffprobe /usr/local/bin/

        # Stage 2: n8n with static ffmpeg (no package manager needed)
        FROM n8nio/n8n:latest
        USER root
        COPY --from=ffmpeg-downloader /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
        COPY --from=ffmpeg-downloader /usr/local/bin/ffprobe /usr/local/bin/ffprobe
        RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
        USER node
        

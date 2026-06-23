{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, wayland-scanner
, sdbus-cpp_2
, wayland
, wayland-protocols
, freetype
, fontconfig
, cairo
, pango
, harfbuzz
, librsvg
, libxkbcommon
, glib
, polkit
, pipewire
, curl
, libqalculate
, libxml2
, libwebp
, mesa
, libepoxy
, linux-pam
, jemalloc
, systemd
}:

stdenv.mkDerivation {
  pname = "noctalia";
  version = "5.0.0-unstable-2026-06-22";

  src = fetchFromGitHub {
    owner = "noctalia-dev";
    repo = "noctalia";
    rev = "da1d0252c7117e869a9095ba1ad504f0b087f068";
    hash = "sha256-LIcWovZOUiR1uWI6ZVkcVl0T/VEw6T+Bo5iLr0w5d34=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wayland-scanner
  ];

  buildInputs = [
    sdbus-cpp_2
    wayland
    wayland-protocols
    freetype
    fontconfig
    cairo
    pango
    harfbuzz
    librsvg
    libxkbcommon
    glib
    polkit
    pipewire
    curl
    libqalculate
    libxml2
    libwebp
    mesa
    libepoxy
    linux-pam
    jemalloc
    systemd
  ];

  mesonFlags = [
    "--buildtype=release"
    "-Dtests=disabled"
  ];

  meta = with lib; {
    description = "Unified desktop shell for Wayland compositors (bars, dock, launcher, notifications, lock screen)";
    homepage = "https://github.com/noctalia-dev/noctalia";
    platforms = platforms.linux;
    mainProgram = "noctalia";
  };
}

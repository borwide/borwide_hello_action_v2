fn main() {
    let mut count = 0;
    loop {
        count += 1;
        println!("Hello, this program is running {} times!", count);
        std::thread::sleep(std::time::Duration::from_secs(5));
    }
}


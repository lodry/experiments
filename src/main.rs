use std::io::stdin;
use std::env;
use std::convert::TryInto;

#[derive(Debug)]
struct Number {
    _type: String,
    number: isize,
}
impl Number {
    fn read_type(&self) -> String {
        self._type.to_string()
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() !=0 {
        for arg in args.iter() {
            let nmb = Number {
                _type: arg.clone(),
                number: 0
            };
            println!("{:?}", nmb);
        }
        println!("fineshed with args parsing.......");

        let str=String::from("strimg");
        let mut str2=&str;
        let sz2 = without_ownership(str2);
        let (sz,str) = with_ownership(str);
        str2 = &str;
        println!("{} {}", sz, sz2);
        println!("{} ", str);
        println!("{} ", str2.clone());
    } else {
     loop {
        let mut nm = String::from("");
        println!("Please Entere number");
        stdin().read_line(&mut nm);
        println!("digit is {}", nm);
        let nmb = Number {
            _type: "small".to_string(),
            number: nm.trim().parse().expect("string please"),
        };
        println!("{:?}", nmb);
        println!("{}", nmb.read_type());
        println!("Do you want more?");
        let mut answer: String = String::new();
        stdin().read_line(&mut answer);
        println!("{} {}", answer, answer == "no");
        if answer.eq("no") {
            break;
        }
    }
    }
}
fn without_ownership(str:&String)->usize{
    str.len()
}
fn with_ownership(str:String)->(usize, String){
    (str.len(), str)
}
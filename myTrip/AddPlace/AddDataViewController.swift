//
//  AddDataViewController.swift
//  myTrip
//
//  Created by ha quang trong on 1/17/19.
//  Copyright © 2019 Le Thanh Thanh Toai. All rights reserved.
//

import UIKit
import Firebase

class AddDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let ref = Database.database().reference().child("places/place3/handbook/description")
        let data = """
1. Thời điểm thích hợp để đi du lịch Vũng Tàu

    Khí hậu Vũng Tàu không quá nóng cũng không quá lạnh cho nên cũng không quá cản trở cho việc đi du lịch. Nhưng các bạn cần hạn chế đi vào tháng 6, tháng 7 vì đây là hai mùa nắng nóng đỉnh điểm tại Vũng Tàu và cũng là dịp nghỉ hè của học sinh, sinh viên vì vậy số lượng du khách tới đây khá đông.

    Nếu bạn muốn lựa chọn thời điểm lí tưởng để đi du lịch Vũng Tàu thì nên đi vào tháng 5, 8, 9, 10. Lúc này, biển Vũng Tàu rất đẹp, êm ái, yên tĩnh đồng thời khí hậu cũng rất mát mẻ và không quá lạnh, bạn có thể trải nghiệm những hoạt động vui nhộn, thú vị tại đây một cách thoải mái nhất vì biển êm, sóng lặng thuận lợi cho việc di chuyển bằng tàu thuyền.
2. Phương tiện di chuyển đến Vũng Tàu

    Khoảng cách từ TP Hồ Chí Minh đến Vũng Tàu là 95,9 KM (đi theo đường QL51) vì vậy việc di chuyển xuống đây cũng khá dễ dàng. Bạn có thể tham khảo các cách đi sau:

    Đi Vũng Tàu bằng xe máy

    Có 2 cung đường đi đến Vũng Tàu bằng xe máy:

    Cung đường 1: Bạn đi theo Quốc lộ 1, qua khỏi cầu Đồng Nai sẽ gặp một bùng binh giao thông (gọi là ngã tư Vũng Tàu), từ đây bạn rẽ phải theo Quốc lộ 51. Đi thêm khoảng 100km là đến TP Vũng Tàu.

    Cung đường 2: Từ TP Hồ Chí Minh, bạn có thể chọn cung đường đi từ phà Cát Lái (Quận 2, TP Hồ Chí Minh) sang Nhơn Trạch (Đồng Nai). Đoạn đường này sẽ dẫn ra quốc lộ 51 đoạn cổng vào Khu công nghiệp Nhơn Trạch, cung đường này gần hơn khoảng 20km.

    Ngoài ra, đối với những bạn nào tự lái ô tô riêng có thể đi cung đường xuống Vũng Tàu qua đường cao tốc Long Thành – Dầu Giây sẽ giúp rút ngắn khoảng cách xuống Vũng Tàu chỉ còn khoảng 2 -2,5 tiếng.

    Đi Vũng Tàu bằng xe khách (ô tô)

    Giá xe khách (ô tô) đi Vũng Tàu dao động từ 80 000 nghìn đồng – 160 000 nghìn đồng/vé.

    - Địa chỉ mua vé đi Vũng Tàu tại TP Hồ Chí Minh: Bến xe miền Đông - 292 Đinh Bộ Lĩnh, Phường 26, Quận Bình Thạnh, TP Hồ Chí Minh.

    Điện thoại: (08) 3899 4056 - (08) 3898 4441 - (08) 3898 4442 - (08) 3898 4893.

    - Địa chỉ mua vé đi TP Hồ Chí Minh tại Vũng Tàu: 192 Nam Kỳ Khởi Nghĩa, Phường 3, TP Vũng Tàu.

    Điện thoại: (064) 3859727.

    Một số hãng xe đi Vũng Tàu uy tín, chất lượng các bạn có thể tham khảo:

    - Hãng xe Hoa Mai

    * Open Tour: Vũng Tàu – Hồ Chí Minh

    Thời gian: 4h00 – 17h30 (mỗi chuyến cách nhau khoảng 15 phút).

    Đặt vé:

    + Quầy vé Vũng Tàu – ĐT: 0643 531 980 – 064 531 981.

    + Quầy vé Bến Thành – ĐT: 0838 218 928 – 0838 218 927.

    * Bến xe Miền Tây

    Thời gian: 4h00 – 19h00 (mỗi chuyến cách nhau khoảng từ 15 – 30 phút)

    Đặt vé:

    + Quầy vé BX Vũng Tàu – Điện thoại: 0643 527 500.

    + Quầy vé BX Miền Tây – Điện thoại: 01207 226 226 – 01207 227 227.

    * Bến xe Miền Đông

    Thời gian: 4h00 – 19h00 (mỗi chuyến cách nhau khoảng từ 15 – 30 phút).

    Đặt vé:

    + Mua vé đi trực tiếp tại Bến xe Vũng Tàu.

    + Mua vé đi trực tiếp tại Bến xe Quầy vé 84 (Hồ Chí Minh).

    + Điện thoại: 0937 756 756.

    - Hãng xe Toàn Thắng

    Điện thoại: 0908 121 135 hoặc 0908 121 135.

    Giá vé xe Toàn Thắng đi Vũng Tàu: 90 000 nghìn đồng/người.

    - Hãng xe Phương Trang

    Giá vé xe Phương Trang đi Vũng Tàu: 95 000 nghìn đồng/vé.
"""
        ref.setValue(data)
    }

}

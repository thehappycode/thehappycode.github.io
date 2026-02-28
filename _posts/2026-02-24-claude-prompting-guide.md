---
title: Claude Prompting Guide
date: 2026-02-23 23:18:00 +0700
categories: [AI, Claude]
tags: [Claude]
---

## Mẹo chung để đặt câu hỏi hiệu quả

### 1. Rõ ràng và cụ thể
   - Nêu rõ nhiệm vụ hoặc câu hỏi của bạn ngay từ đầu tin nhắn.
   - Cung cấp ngữ cảnh và chi tiết để Claude hiểu đúng nhu cầu của bạn.
   - Chia các nhiệm vụ phức tạp thành các bước nhỏ, dễ thực hiện hơn.

   Prompt kém:
   <prompt>
   "Giúp tôi với bài thuyết trình."
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi cần trợ giúp tạo bài thuyết trình 10 slide cho cuộc họp doanh số quý của chúng tôi. Bài thuyết trình nên bao gồm kết quả bán hàng Q2, các sản phẩm bán chạy nhất và mục tiêu doanh số Q3. Hãy cung cấp dàn ý với các điểm chính cho mỗi slide."
   </prompt>

   Tại sao tốt hơn: Prompt tốt cung cấp thông tin cụ thể về nhiệm vụ, bao gồm số lượng slide, mục đích của bài thuyết trình và các chủ đề chính cần đề cập.

### 2. Sử dụng ví dụ
   - Cung cấp ví dụ về loại kết quả bạn muốn.
   - Nếu bạn muốn một định dạng hoặc phong cách cụ thể, hãy đưa ra ví dụ cho Claude.

   Prompt kém:
   <prompt>
   "Viết một email chuyên nghiệp."
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi cần viết email chuyên nghiệp gửi khách hàng về việc dự án bị trễ tiến độ. Đây là email tương tự tôi đã gửi trước đây:

   'Kính gửi [Khách hàng],
   Hy vọng email này tìm thấy bạn trong tình trạng tốt. Tôi muốn cập nhật cho bạn về tiến độ của [Tên dự án]. Thật không may, chúng tôi đã gặp phải một vấn đề bất ngờ khiến ngày hoàn thành bị trễ khoảng hai tuần. Chúng tôi đang nỗ lực giải quyết và sẽ tiếp tục cập nhật tiến độ cho bạn.
   Vui lòng liên hệ nếu bạn có thắc mắc hoặc lo ngại.
   Trân trọng,
   [Tên bạn]'

   Hãy giúp tôi soạn thảo email mới theo giọng điệu và cấu trúc tương tự, nhưng cho tình huống hiện tại của chúng tôi là bị trễ một tháng do vấn đề chuỗi cung ứng."
   </prompt>

   Tại sao tốt hơn: Prompt tốt cung cấp ví dụ cụ thể về phong cách và giọng điệu mong muốn, giúp Claude có điểm tham chiếu rõ ràng để soạn email mới.

### 3. Khuyến khích tư duy có hệ thống
   - Với các nhiệm vụ phức tạp, hãy yêu cầu Claude "suy nghĩ từng bước" hoặc "giải thích lý luận của bạn".
   - Điều này có thể dẫn đến các câu trả lời chính xác và chi tiết hơn.

   Prompt kém:
   <prompt>
   "Làm thế nào để tôi cải thiện năng suất của đội nhóm?"
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi muốn cải thiện năng suất của đội nhóm. Hãy suy nghĩ từng bước, xem xét các yếu tố sau:
   1. Các vấn đề đang cản trở năng suất hiện tại (ví dụ: quá nhiều cuộc họp, ưu tiên không rõ ràng)
   2. Các giải pháp tiềm năng (ví dụ: kỹ thuật quản lý thời gian, công cụ quản lý dự án)
   3. Các thách thức khi triển khai
   4. Phương pháp đo lường sự cải thiện

   Với mỗi bước, hãy cung cấp giải thích ngắn gọn về lý luận của bạn. Sau đó tóm tắt các ý kiến của bạn ở cuối."
   </prompt>

   Tại sao tốt hơn: Prompt tốt yêu cầu Claude suy nghĩ có hệ thống về vấn đề, cung cấp cấu trúc hướng dẫn rõ ràng và yêu cầu giải thích quá trình lý luận. Nó cũng nhắc Claude tạo tóm tắt ở cuối để dễ đọc hơn.

### 4. Tinh chỉnh qua nhiều lần
   - Nếu câu trả lời đầu tiên của Claude chưa đúng ý, hãy yêu cầu làm rõ hoặc chỉnh sửa.
   - Bạn luôn có thể nói "Gần đúng rồi, nhưng bạn có thể điều chỉnh X để giống Y hơn không?"

   Prompt kém:
   <prompt>
   "Làm cho nó tốt hơn."
   </prompt>

   Prompt tốt:
   <prompt>
   "Đó là một khởi đầu tốt, nhưng hãy tinh chỉnh thêm. Thực hiện các điều chỉnh sau:
   1. Làm cho giọng điệu thân thiện và dễ gần hơn
   2. Thêm ví dụ cụ thể về cách sản phẩm của chúng tôi đã giúp ích cho một khách hàng
   3. Rút gọn đoạn thứ hai để tập trung nhiều hơn vào lợi ích thay vì tính năng"
   </prompt>

   Tại sao tốt hơn: Prompt tốt cung cấp phản hồi cụ thể và hướng dẫn rõ ràng để cải thiện, cho phép Claude thực hiện các điều chỉnh có mục tiêu thay vì chỉ dựa vào cảm nhận chủ quan của Claude về "tốt hơn" — điều này thường khác với định nghĩa của người dùng!

### 5. Tận dụng kiến thức của Claude
   - Claude có kiến thức rộng trên nhiều lĩnh vực. Đừng ngần ngại yêu cầu giải thích hoặc thông tin nền tảng.
   - Hãy đảm bảo cung cấp đầy đủ ngữ cảnh và chi tiết liên quan để câu trả lời của Claude phục vụ tốt nhất cho nhu cầu của bạn.

   Prompt kém:
   <prompt>
   "Marketing là gì? Làm thế nào để tôi thực hiện nó?"
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi đang phát triển chiến lược marketing cho dòng sản phẩm tẩy rửa thân thiện với môi trường mới. Bạn có thể cung cấp tổng quan về các xu hướng hiện tại trong green marketing không? Vui lòng bao gồm:
   1. Các chiến lược thông điệp chính phù hợp với người tiêu dùng có ý thức về môi trường
   2. Các kênh hiệu quả để tiếp cận đối tượng này
   3. Ví dụ về các chiến dịch green marketing thành công trong năm qua
   4. Các rủi ro cần tránh (ví dụ: bị cáo buộc greenwashing)

   Thông tin này sẽ giúp tôi định hình cách tiếp cận marketing của chúng tôi."
   </prompt>

   Tại sao tốt hơn: Prompt tốt yêu cầu thông tin cụ thể, phù hợp với ngữ cảnh, tận dụng kiến thức rộng của Claude. Nó cung cấp bối cảnh về cách thông tin sẽ được sử dụng, giúp Claude đóng khung câu trả lời theo cách phù hợp nhất.

### 6. Sử dụng nhập vai
   - Yêu cầu Claude đảm nhận một vai trò hoặc góc nhìn cụ thể khi trả lời.

   Prompt kém:
   <prompt>
   "Giúp tôi chuẩn bị cho một cuộc đàm phán."
   </prompt>

   Prompt tốt:
   <prompt>
   "Bạn là nhà cung cấp vải cho công ty sản xuất ba lô của tôi. Tôi đang chuẩn bị đàm phán với nhà cung cấp này để giảm giá 10%. Với vai trò là nhà cung cấp, hãy cung cấp:
   1. Ba phản đối tiềm năng đối với yêu cầu giảm giá của chúng tôi
   2. Với mỗi phản đối, hãy đề xuất lập luận phản bác từ góc độ của tôi
   3. Hai đề xuất thay thế mà nhà cung cấp có thể đưa ra thay vì giảm giá thẳng

   Sau đó, hãy đổi vai và cung cấp lời khuyên về cách tôi, với vai trò là người mua, có thể tiếp cận cuộc đàm phán này tốt nhất để đạt được mục tiêu của mình."
   </prompt>

   Tại sao tốt hơn: Prompt này sử dụng nhập vai để khám phá nhiều góc độ của cuộc đàm phán, cung cấp sự chuẩn bị toàn diện hơn. Nhập vai cũng khuyến khích Claude dễ dàng áp dụng các sắc thái của các góc nhìn cụ thể hơn, nâng cao chất lượng phản hồi.


## Mẹo và ví dụ theo từng loại nhiệm vụ

### Tạo nội dung

1. **Xác định đối tượng của bạn**
   - Cho Claude biết nội dung dành cho ai.

   Prompt kém:
   <prompt>
   "Viết gì đó về an ninh mạng."
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi cần viết bài blog về các thực hành bảo mật an ninh mạng tốt nhất cho chủ doanh nghiệp nhỏ. Đối tượng không rành về công nghệ, vì vậy nội dung cần:
   1. Dễ hiểu, tránh thuật ngữ kỹ thuật nếu có thể
   2. Thực tế, với các mẹo có thể thực hiện được ngay
   3. Hấp dẫn và hơi hài hước để duy trì sự chú ý

   Hãy cung cấp dàn ý cho bài blog 1000 từ bao gồm 5 thực hành an ninh mạng hàng đầu mà các chủ doanh nghiệp này nên áp dụng."
   </prompt>

   Tại sao tốt hơn: Prompt tốt chỉ định đối tượng, giọng điệu mong muốn và các đặc điểm chính của nội dung, cung cấp hướng dẫn rõ ràng để tạo ra kết quả phù hợp và hiệu quả.

2. **Xác định giọng điệu và phong cách**
   - Mô tả giọng điệu mong muốn.
   - Nếu bạn có hướng dẫn phong cách, hãy đề cập các điểm chính.

   Prompt kém:
   <prompt>
   "Viết mô tả sản phẩm."
   </prompt>

   Prompt tốt:
   <prompt>
   "Hãy giúp tôi viết mô tả sản phẩm cho chiếc ghế văn phòng ergonomic mới của chúng tôi. Sử dụng giọng điệu chuyên nghiệp nhưng hấp dẫn. Phong cách thương hiệu của chúng tôi thân thiện, sáng tạo và quan tâm đến sức khỏe. Mô tả cần:
   1. Làm nổi bật các tính năng ergonomic chính của ghế
   2. Giải thích cách các tính năng này mang lại lợi ích cho sức khỏe và năng suất của người dùng
   3. Đề cập ngắn gọn về vật liệu bền vững được sử dụng
   4. Kết thúc bằng lời kêu gọi hành động khuyến khích độc giả dùng thử ghế

   Nhắm đến khoảng 200 từ."
   </prompt>

   Tại sao tốt hơn: Prompt này cung cấp hướng dẫn rõ ràng về giọng điệu, phong cách và các yếu tố cụ thể cần bao gồm trong mô tả sản phẩm.

3. **Xác định cấu trúc đầu ra**
   - Cung cấp dàn ý cơ bản hoặc danh sách các điểm bạn muốn đề cập.

   Prompt kém:
   <prompt>
   "Tạo bài thuyết trình về kết quả công ty."
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi cần tạo bài thuyết trình về kết quả Q2. Cấu trúc theo các phần sau:
   1. Tổng quan
   2. Hiệu suất bán hàng
   3. Thu hút khách hàng
   4. Thách thức
   5. Triển vọng Q3

   Với mỗi phần, hãy đề xuất 3-4 điểm chính cần đề cập, dựa trên các bài thuyết trình kinh doanh thông thường. Đồng thời, đề xuất một loại hình ảnh hóa dữ liệu (ví dụ: biểu đồ, đồ thị) phù hợp cho mỗi phần."
   </prompt>

   Tại sao tốt hơn: Prompt này cung cấp cấu trúc rõ ràng và yêu cầu các yếu tố cụ thể (điểm chính và hình ảnh hóa dữ liệu) cho mỗi phần.

### Tóm tắt tài liệu và hỏi đáp

1. **Cụ thể về những gì bạn muốn**
   - Yêu cầu tóm tắt các khía cạnh hoặc phần cụ thể của tài liệu.
   - Đặt câu hỏi rõ ràng và trực tiếp.
   - Hãy chỉ định loại tóm tắt (cấu trúc đầu ra, loại nội dung) bạn muốn.

2. **Sử dụng tên tài liệu**
   - Tham chiếu tài liệu đính kèm theo tên.

3. **Yêu cầu trích dẫn**
   - Yêu cầu Claude trích dẫn các phần cụ thể của tài liệu trong câu trả lời.

Đây là ví dụ kết hợp cả ba kỹ thuật trên:

   Prompt kém:
   <prompt>
   "Tóm tắt báo cáo này cho tôi."
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi đã đính kèm báo cáo nghiên cứu thị trường 50 trang có tên 'Xu hướng ngành công nghệ 2023'. Bạn có thể cung cấp tóm tắt 2 đoạn văn tập trung vào xu hướng AI và machine learning không? Sau đó, hãy trả lời các câu hỏi sau:
   1. 3 ứng dụng AI hàng đầu trong kinh doanh năm nay là gì?
   2. Machine learning đang ảnh hưởng như thế nào đến các vai trò công việc trong ngành công nghệ?
   3. Báo cáo đề cập đến những rủi ro hoặc thách thức nào liên quan đến việc áp dụng AI?

   Hãy trích dẫn các phần hoặc số trang cụ thể khi trả lời các câu hỏi này."
   </prompt>

   Tại sao tốt hơn: Prompt này xác định trọng tâm chính xác của tóm tắt, đưa ra các câu hỏi cụ thể và yêu cầu trích dẫn, đảm bảo phản hồi có mục tiêu và hữu ích hơn.

### Phân tích dữ liệu và trực quan hóa

1. **Chỉ định định dạng mong muốn**
   - Mô tả rõ ràng định dạng bạn muốn dữ liệu xuất hiện.

   Prompt kém:
   <prompt>
   "Phân tích dữ liệu bán hàng của chúng tôi."
   </prompt>

   Prompt tốt:
   <prompt>
   "Tôi đã đính kèm bảng tính có tên 'Dữ liệu bán hàng 2023'. Bạn có thể phân tích dữ liệu này và trình bày các phát hiện chính theo định dạng sau không:

   1. Tóm tắt điều hành (2-3 câu)

   2. Các chỉ số chính:
      - Tổng doanh thu mỗi quý
      - Danh mục sản phẩm hoạt động tốt nhất
      - Khu vực tăng trưởng cao nhất

   3. Xu hướng:
      - Liệt kê 3 xu hướng đáng chú ý, mỗi xu hướng kèm giải thích ngắn

   4. Khuyến nghị:
      - Cung cấp 3 khuyến nghị dựa trên dữ liệu, mỗi khuyến nghị kèm lý do ngắn

   Sau phân tích, đề xuất ba loại hình ảnh hóa dữ liệu có thể truyền đạt hiệu quả các phát hiện này."
   </prompt>

   Tại sao tốt hơn: Prompt này cung cấp cấu trúc rõ ràng cho phân tích, xác định các chỉ số chính cần tập trung và yêu cầu đề xuất khuyến nghị và hình ảnh hóa.

### Brainstorming
 1. Sử dụng Claude để tạo ra ý tưởng bằng cách yêu cầu danh sách các khả năng hoặc giải pháp thay thế.
     - Cụ thể về các chủ đề bạn muốn Claude đề cập trong phiên brainstorming.

   Prompt kém:
   <prompt>
   "Cho tôi một số ý tưởng xây dựng nhóm."
   </prompt>

   Prompt tốt:
   <prompt>
   "Chúng tôi cần nghĩ ra các hoạt động xây dựng đội nhóm cho nhóm 20 người làm việc từ xa. Bạn có thể giúp tôi brainstorming bằng cách:
   1. Đề xuất 10 hoạt động xây dựng đội nhóm ảo thúc đẩy sự hợp tác
   2. Với mỗi hoạt động, giải thích ngắn gọn cách nó thúc đẩy tinh thần đồng đội
   3. Chỉ ra hoạt động nào phù hợp nhất cho:
      a) Làm quen ban đầu
      b) Cải thiện giao tiếp
      c) Kỹ năng giải quyết vấn đề
   4. Đề xuất một lựa chọn chi phí thấp và một lựa chọn cao cấp."
   </prompt>

   Tại sao tốt hơn: Prompt này cung cấp các thông số cụ thể cho phiên brainstorming, bao gồm số lượng ý tưởng, loại hoạt động và phân loại bổ sung, tạo ra kết quả có cấu trúc và hữu ích hơn.

2. Yêu cầu phản hồi theo các định dạng cụ thể như gạch đầu dòng, danh sách đánh số hoặc bảng để dễ đọc hơn.

   Prompt kém:
   <prompt>
   "So sánh các tùy chọn phần mềm quản lý dự án."
   </prompt>

   Prompt tốt:
   <prompt>
   "Chúng tôi đang xem xét ba tùy chọn phần mềm quản lý dự án: Asana, Trello và Microsoft Project. Bạn có thể so sánh các phần mềm này theo định dạng bảng với các tiêu chí sau không:
   1. Tính năng chính
   2. Dễ sử dụng
   3. Khả năng mở rộng
   4. Giá cả (bao gồm các gói cụ thể nếu có)
   5. Khả năng tích hợp
   6. Phù hợp nhất cho (ví dụ: nhóm nhỏ, doanh nghiệp, ngành cụ thể)"
   </prompt>

   Tại sao tốt hơn: Prompt này yêu cầu cấu trúc cụ thể (bảng) để so sánh, cung cấp tiêu chí rõ ràng, giúp thông tin dễ hiểu và áp dụng.

## Khắc phục sự cố, giảm thiểu ảo giác và tối đa hóa hiệu suất

1. **Cho phép Claude thừa nhận sự không chắc chắn**
   - Hãy nói với Claude rằng nên nói không biết nếu thực sự không biết. Ví dụ: "Nếu bạn không chắc về điều gì đó, bạn có thể thừa nhận điều đó. Cứ nói là bạn không biết."

2. **Chia nhỏ các nhiệm vụ phức tạp**
   - Nếu một nhiệm vụ có vẻ quá lớn và Claude bỏ sót các bước hoặc không thực hiện tốt một số bước, hãy chia thành các bước nhỏ hơn và làm việc với Claude từng tin nhắn một.

3. **Bao gồm tất cả thông tin ngữ cảnh cho các yêu cầu mới**
   - Claude không lưu giữ thông tin từ các cuộc trò chuyện trước đó, vì vậy hãy đưa vào tất cả ngữ cảnh cần thiết trong mỗi cuộc trò chuyện mới.

## Ví dụ prompt tốt và kém

Đây là các ví dụ bổ sung kết hợp nhiều kỹ thuật đặt câu hỏi để thể hiện sự khác biệt rõ rệt giữa các prompt kém hiệu quả và hiệu quả cao.

### Ví dụ 1: Phát triển chiến lược marketing

Prompt kém:
<prompt>
"Giúp tôi tạo chiến lược marketing."
</prompt>

Prompt tốt:
<prompt>
"Với vai trò là chuyên gia tư vấn marketing cấp cao, tôi cần sự trợ giúp của bạn để phát triển chiến lược marketing toàn diện cho dòng phụ kiện điện thoại thân thiện với môi trường mới của chúng tôi. Đối tượng mục tiêu là millennials và Gen Z có ý thức về môi trường. Hãy cung cấp chiến lược chi tiết bao gồm:

1. Phân tích thị trường:
   - Xu hướng hiện tại trong phụ kiện công nghệ thân thiện với môi trường
   - 2-3 đối thủ cạnh tranh chính và chiến lược của họ
   - Quy mô thị trường tiềm năng và dự báo tăng trưởng

2. Persona đối tượng mục tiêu:
   - Mô tả chi tiết về khách hàng lý tưởng của chúng tôi
   - Vấn đề họ gặp phải và cách sản phẩm của chúng tôi giải quyết

3. Marketing Mix:
   - Sản phẩm: Các tính năng chính cần làm nổi bật
   - Giá cả: Chiến lược định giá được đề xuất với lý do
   - Địa điểm: Kênh phân phối được khuyến nghị
   - Khuyến mãi:
     a) 5 kênh marketing cần tập trung, với ưu và nhược điểm của mỗi kênh
     b) 3 ý tưởng chiến dịch sáng tạo để ra mắt

4. Chiến lược nội dung:
   - 5 chủ đề nội dung phù hợp với đối tượng của chúng tôi
   - Các loại nội dung được đề xuất (ví dụ: bài blog, video, infographic)

5. KPI và Đo lường:
   - 5 chỉ số chính cần theo dõi
   - Các công cụ được đề xuất để đo lường các chỉ số này

Hãy trình bày thông tin này theo định dạng có cấu trúc với tiêu đề và gạch đầu dòng. Khi có liên quan, hãy giải thích lý do hoặc cung cấp ví dụ ngắn.

Sau khi phác thảo chiến lược, hãy xác định các thách thức hoặc rủi ro tiềm ẩn cần chú ý và đề xuất các chiến lược giảm thiểu cho mỗi rủi ro."
</prompt>

Tại sao tốt hơn: Prompt này kết hợp nhiều kỹ thuật bao gồm giao vai trò, chia nhỏ nhiệm vụ cụ thể, yêu cầu đầu ra có cấu trúc, brainstorming (cho ý tưởng chiến dịch và chủ đề nội dung) và yêu cầu giải thích. Nó cung cấp hướng dẫn rõ ràng trong khi vẫn để chỗ cho phân tích và sáng tạo của Claude.

### Ví dụ 2: Phân tích báo cáo tài chính

Prompt kém:
<prompt>
"Phân tích báo cáo tài chính này."
</prompt>

Prompt tốt:
<prompt>
"Tôi đã đính kèm báo cáo tài chính Q2 của công ty có tên 'Q2_2023_Bao_Cao_Tai_Chinh.pdf'. Hãy đóng vai CFO giàu kinh nghiệm và phân tích báo cáo này, sau đó chuẩn bị tóm tắt cho hội đồng quản trị. Hãy cấu trúc phân tích của bạn như sau:

1. Tóm tắt điều hành (3-4 câu nêu bật các điểm chính)

2. Tổng quan hiệu suất tài chính:
   a) Doanh thu: So sánh với quý trước và cùng quý năm ngoái
   b) Biên lợi nhuận: Gộp và Ròng, với giải thích cho bất kỳ thay đổi đáng kể nào
   c) Dòng tiền: Làm nổi bật bất kỳ mối lo ngại hoặc diễn biến tích cực

3. Các chỉ số hiệu suất chính:
   - Liệt kê 5 KPI hàng đầu và trạng thái hiện tại (Sử dụng định dạng bảng)
   - Với mỗi KPI, cung cấp giải thích ngắn gọn về ý nghĩa và xu hướng đáng chú ý

4. Phân tích theo phân khúc:
   - Chia nhỏ hiệu suất theo ba phân khúc kinh doanh chính
   - Xác định phân khúc hoạt động tốt nhất và kém nhất, kèm lý do tiềm năng

5. Xem xét bảng cân đối kế toán:
   - Làm nổi bật bất kỳ thay đổi đáng kể về tài sản, nợ phải trả hoặc vốn chủ sở hữu
   - Tính toán và giải thích các tỷ lệ chính (ví dụ: tỷ lệ hiện tại, nợ trên vốn chủ sở hữu)

6. Các phát biểu hướng về tương lai:
   - Dựa trên dữ liệu này, cung cấp 3 dự đoán chính cho Q3
   - Đề xuất 2-3 bước chiến lược cần xem xét để cải thiện vị thế tài chính

7. Đánh giá rủi ro:
   - Xác định 3 rủi ro tài chính tiềm ẩn dựa trên báo cáo này
   - Đề xuất các chiến lược giảm thiểu rủi ro cho từng rủi ro

8. So sánh đồng nghiệp:
   - So sánh hiệu suất của chúng tôi với 2-3 đối thủ cạnh tranh chính (sử dụng dữ liệu công khai)
   - Làm nổi bật các lĩnh vực chúng tôi đang vượt trội và các lĩnh vực cần cải thiện

Hãy sử dụng biểu đồ hoặc bảng khi cần thiết để trực quan hóa dữ liệu. Với bất kỳ giả định hoặc diễn giải nào bạn thực hiện, hãy nêu rõ ràng và cung cấp lý do.

Sau khi hoàn thành phân tích, hãy tạo ra 5 câu hỏi tiềm năng mà thành viên hội đồng có thể đặt ra về báo cáo này, cùng với các câu trả lời được đề xuất.

Cuối cùng, hãy tóm tắt toàn bộ phân tích này thành một đoạn văn duy nhất mà tôi có thể sử dụng làm phát biểu mở đầu trong cuộc họp hội đồng."
</prompt>

Tại sao tốt hơn: Prompt này kết hợp nhập vai (với tư cách CFO), đầu ra có cấu trúc, yêu cầu phân tích dữ liệu cụ thể, phân tích dự đoán, đánh giá rủi ro, phân tích so sánh và thậm chí dự đoán các câu hỏi tiếp theo. Nó cung cấp một khung rõ ràng trong khi khuyến khích phân tích sâu và tư duy chiến lược.

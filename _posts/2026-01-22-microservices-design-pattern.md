---
title: Microservices Design Pattern
date: 2026-01-22 23:18:00 +0700
categories: [Mindmap]
tags: [Design Patterns]
mermaid: true
---

```mermaid
mindmap
  root((Microservices Design Pattern))
    
    {{Chapter 01}}
      
    {{Chapter 02}}

    {{**Chapter 03**
      Interprocess communication in
      a microservice architecture
    }}
      (**synchronous**
        HTTP
      )
        (**Defining APIs**
            - Thiết kế tốt nhất 
              là sử dụng interface để
              expose các chức năng
              và ẩn các phẩn thực hiện
            - API-first design: 
              Thống nhất với team FE
              trước về tên api, cấu trúc
              request, cấu trúc response
              trước khi bắt đầu
              thực hiện code.
            - Sử dụng Semantic Versioning khi nâng cấp API
          )
        (REST API)
          (**IDL**
           như OpenApi Specification để expose chức năng
          )
          (**Thách thức khi cần fetch 
            nhiều resource trong một reqeust**
            Chúng ta có thể sử dụng 
            **Graphql** để thay thế
          )
          (**Thử thách khi mapping nhiều hành động tới http verb**
            Một REST API sử dụng PUT để update, nhưng chúng ta có nhiều cách để update một đối tượng.
            Ví dụ như: cancel, và reverse.
            Để giải quyết vấn đề này chúng ta nên sử dụng sub-resource cho từng update như:
            /api/orders/#123;orderId#125;/cancel và /api/orders/#123;orderId#125;/reverse
          )
        (gRPC)
          (gRPC sẽ tránh được các thử thách của REST API như:
            - HTTP chỉ cung cấp giới hạn verb
          )
          (gRPC là một 
            binary mesage-base protocol
          )
          (gRPC hỗ trợ stream RPC)
          (Bạn có thể defined gRPC APIs 
            sử dụng Protocol Buffers-based IDL.
            Protocol Buffer phải sử dụng format HTTP/2
          )
        (Handling partial failure using
          the Circuit breaker pattern
        )
          (Nếu số lượng request lỗi vượt ngưỡng cho phép
           thì sẽ trip circuit breaker và trả lỗi trực tiếp
          )
        (Using service discovery)
          (Giải quyết bài toàn về xác định ip:port 
            khi hệ thống autoscaling, failures và upgrades
          )
          (Có 2 pattern để triển khai)
            (Self registration pattern)
              (Khi cần đăng ký network local #40;ip:port#41;
               sẽ gọi đến Registration API trong service registry
              )
              (Khi sử dụng thì clien sẽ query đến Query API
                trong service registry để lấy danh sách network local
              )
            (Application level servie discovery như: Netflix, Eureka.
              Sử dụng DNS thay cho network
              local
            )
              (Khi cần đăng ký thì gọi vào
               3rd party registration pattern
              )
              (Khi cần sử dụng thì gọi vào
               server-side discovery pattern
              )
        
      (**asynchronous**
        Message Broker
      )
        (**Message format**
          - Text: JSON, XML
          - Binary: Protocol Buffers, Avro
        )
        (AMQP)
        (STOMP)
        (Overview of message
          Sender: Write a message to channel
          Receiver: Read a message from channel
        )
          (About message)
            (**header**: là tập hợp cặp key-value
              trình bày data của sender.
            )
              (Header có một `uniquer message id`)
              (Optional `return address` để reply)
            (**body**: là data sender, có thể là text hoặc binary)
          (About message channel)
            (Message channel là nơi trao đổi message)
            (Message channel là một abstraction của message infrastructure)
            (Có hai loại message channel)
              (**point to point**)
                (Channel sẽ chuyển message
                  đến chính xác consumer
                )
                (Là loại giao tiếp tương tác
                  one-to-one
                )
              (**publish-subscribe**)
                (Channel sẽ chuyển message
                  đến tất cả consumer đã được
                  liên kết #40;*acttached*#41;
                )
                (Là loại giao tiếp tương tác
                 one-to-many
                )
        (Các loại giao tiếp khi sử dụng messaing)
          (Request/Response và asynchronous request/response)
            (**Asynchronous request/response**
              Message vốn dĩ là bất đồng bộ
              nên chỉ cung cấp asynchronous request/response
            )
            (**Request/Response**
              Để nhận reply thì client phải block
             cho đến khi nhận được message phản hồi
            )
              (Client sử dụng point-to-point channel)
              (Client send message với header phải có có reply channel,
                message id #40correlation id#
              )
              (Server sử dụng thông tin từ reply channel,
                messageId để gửi 1 message về Client
              )
              (Client sẽ match correlation id để phản hồi request)
          (One-way notification)
          (Publish/Subscribe)
          (Publish/Async Response)
        (Sử dụng message broker)
          (Brokerless messaging)
            (Ưu điểm)
              (Kiến trúc brokerless, các services
                sẽ trao đổi message trực tiếp với nhau
              )
              (Allows lighter network traffice
                and better lantency
              )
              (Loại trừ việc thắt cổ chay
              tại một điểm như message broker
              )
              (Tính năng ít phức tạp hơn message broker)
            (Nhược điểm)
              (Vì các services phải biết vị trí
                của service khác nên bắt buộ
                phải sử dụng service discorery
              )
              (Giảm độ khả dụng bời vì
                cả sender và receiver bắt buộc
                phải khả dụng trong quá trình trao đổi message
              )
              (Việc thực hiện cơ chế 
                đảm bảo message luôn được giao là một thử thách
              )
          (Overview of broker-based massaging)
            (Message broker là trung gian
             trong tất cả luồng message
            )
            (Sender không cần biết network của consumer)
            (Message Broker sẽ buffers message
             cho đến khi consumer xử lý chúng
            )
            (Các nhân tố khi lưa chọn message broker)
              (Supported programming languages?)
              (Supported messaging standards như: AMQP và STOMP?)
              (Messaging ordering: Messge broker có bảo toàn được thứ tự messages?)
              (Delivery guarantees: Đảm bảo message sẽ luôn được giao?)
              (Persistense: Message có được lưu trữ ở disk và có thể tồn tại nếu broker crashes?)
              (Durability: Nếu consumer kết nối lại với messege broker, nó có nhận được message đã được chuyển khi nó bị mất kết nối không?)
              (Scalability: Cách nào để scalable trong message broker?)
              (Latency)
              (Competing consumers: Message broker có hỗ trợ việc tranh chấp consumers không?)
            (Ưu điểm)
              (Loose couping)
              (Message buffering)
              (Flexible communication)
              (Explicit interprocess communication)
            (Nhược điểm)
              (Potential performance bottleneck)
              (Potential single point of failure)
              (Additional operational complexity)
        (Competing receivers and message ordering)
          (Thách thức)
            (Làm cách nào để scale thêm message receivers trong khi vẫn bảo toàn được thứ tự của messaging)
            (Đảm bảo mỗi message chỉ được xử lý một lần và đúng thứ tự order)
            (Ví dụ chúng ta có nhiều install của một service để xử lý messages concurrently. Hơn nữa một install của một service sử dụng nhiều threads để xử lý messages concurently)
          (Giải pháp: Sử dụng shared/partitioned) channel. Gồm 3 phần)
            (Mỗi shared channel sẽ chứa hai hoặc nhiều shareds, mỗi shared có hành vi giống với một channel)
            (Sender sẽ gửi đúng **shared-key** trong các messages header)
              (Shared-key có thể là một string, hoặc một chuỗi bytes)
              (Message broker sẽ dùng shared-key để assign message đến shared/partition )
            (Message broker sẽ gôm nhiều install receiver lại với nhau, và xem chúng có cùng một logical receiver. Message broker sẽ assign mỗi shared/parttion cho một single receiver)
        (Handling duplicate message)
          (Thách thức)
            (Một thử thách khác phải giải quyết khi sử dụng message broker là duplicate messages. Nhưng khi có lỗi client, network hoặc message broker huỷ kết quả, và messager được giao lại nhiều lần)
            (Ví dụ client bị crashes sau khi sử lý một message và đã updated database, nhưng trước khi acknowledging message. Message broker sẽ giao lại message có trạng thái unacknowledged khi client restart hoặc một client install khác)
          (Giải pháp: có cách khác nhau)
            (Write idempotent message handler)
              (Application có logic idempotent (tạm hiểu là logic theo hướng sự kiện), khi đó duplicate message sẽ vô hiệu)
            (Tracking messages and discarding duplicates)
              (Chúng ta sẽ lưu messageId và domain events (idempotent) vào trong databse với table PROCESSED_MESSAGES. Nếu duplicate message thì khi insert vào databse sẽ báo lỗi và discard message)
        (Transactional messaging)
          (Using a database table as a message queue)
          (Publishing events by using the polling publisher pattern)
          (Publishing events by applying the transaction log tailing pattern)





    {{Chapter 04}}

    {{Chapter 05}}
```
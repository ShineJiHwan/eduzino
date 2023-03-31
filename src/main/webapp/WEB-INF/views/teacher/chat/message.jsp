<%@page import="com.edu.zino.domain.Chat"%>
<%@page import="com.edu.zino.domain.OrderSummary"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<OrderSummary> orderSummaryList = (List)request.getAttribute("orderSummaryList");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Teacher Chat-Message</title>
    <!-- plugins:css -->
    <jsp:include page="../inc/header_link.jsp"></jsp:include>
  </head>
  <body>

<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">EduZino</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="bt_messageOk">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>



    <div class="container-scroller">
      <!-- partial:partials/_sidebar.html -->
      <jsp:include page="../inc/sidebar.jsp"></jsp:include>
      <!-- sidebar.html end  -->
      
      <!-- partial  -->
      <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_settings-panel.html -->
        <!-- partial -->
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="../inc/navbar.jsp"></jsp:include>
        <!-- partial -->
        <div class="main-panel">
    <div class="chat-container p-0">
		<div class="card-chat">
			<div class="row-chat g-0">
			
				<!-- 채팅방 -->
				<div class="col-12 col-lg-5 col-xl-3 border-right">

					<div class="px-4 d-none d-md-block">
						<div class="d-flex align-items-center">
						
							<select class="form-control form-control-sm my-3" id="chatMember">
		                        <option value="0">수강생을 선택하세요</option>
		                        <% for(int i=0;i<orderSummaryList.size();i++){ %>
	                        	<%
	                        		OrderSummary orderSummary = orderSummaryList.get(i);
	                        	%>
		                        <option value="<%= orderSummary.getMember().getMember_idx() %>"><%= orderSummary.getMember().getMember_nickname() %></option>
		                        <% } %>
	                    	</select>
							
							<div class="chat-icon mdi mdi-comment-plus-outline" id="addChat"></div>
						</div>
					</div>
					
					<section id="app_chatRooms">
						<template v-for="chat in chatList">
							<row :key="chat.member_teacher_idx" :obj="chat" />
						</template>
					</section>

					<hr class="d-block d-lg-none mt-1 mb-0">
				</div>
				
				<!-- 채팅내용 -->
				<div class="col-12 col-lg-7 col-xl-9">
					<div class="py-2 px-4 border-bottom d-none d-lg-block chat-item-float-overflow">
					
						<section id="app_chatHeader">
							<template v-if="flag">
								<chat_header :key="chat.member.member_idx" :obj="chat" />
							</template>
						</section>
						
					</div>

					<div class="position-relative" style="height:500px; overflow: auto;" id="chatAreaScroll">
						<div class="chat-messages p-4" id="chatArea">
						
							
						</div>
					</div>

					<div class="flex-grow-0 py-3 px-4 border-top">

							<section id="app_chatFooter">
								<template v-if="flag">
									<chat_footer :key="chat.member.member_idx" :obj="chat" />
								</template>
							</section>
							
					</div>

				</div>
			</div>
		</div>
	</div>

        </div>
        <!-- main-panel ends -->
      </div>
      <!-- partial end  -->
      <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->
    <!-- plugins:js -->
		<jsp:include page="../inc/footer_link.jsp"></jsp:include>
    <!-- plugins:js end -->
    <!-- End custom js for this page -->
  </body>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.18/vue.min.js"></script>
  <script type="text/javascript">
  

  
  /*----------------------------------------------------------------------------------------------
  웹소켓 메세지 주고받기
  --------------------------------------------------------------------------------------------------*/
  
  //websocket관련
	let ws;
	let socket = null;
	let flag = true; //수강생조회하는 폼 보이거나 숨길 때 사용


  //웹소켓을 이용한 서버에 접속(채팅입장시 호출)
  function connect(chat){
  	ws=new WebSocket("ws://localhost:7777/chat");
  	
  	ws.onopen=function(){
  		//웹소켓 연결됐을 때 호출될 함수
  		console.log("서버에 접속됨 onopen");
	  	ws.send(chat.chat_idx + "," + chat.member_teacher.member_idx + "," + chat.member.member_idx + "," + "ENTER-CHAT"); //보내는 내용  			
  	}
  	
  	ws.onmessage=function(e){
  		console.log("서버가 보낸 데이터/선생님이 받은 데이터", e.data);
  		
  		//서버가 보낸 메시지를 area에 누적 
  		//$("#t_receive").append(e.data+"\n");
  		
  		let sm = e.data;
  		let sl = sm.split(',');
  		let roomNum = sl[0];
		let sendId = sl[1]; //추후 누가 member_idx
		let resiveId = sl[2]; //추후 누구에게 member_idx
		let content = sl[3];
  		if(roomNum == chat.chat_idx && sendId != chat.member_teacher.member_idx && content != "ENTER-CHAT"){
			showMessageLeftCard(chat, content);
  		}
  	}
  	
  	ws.onclose=function(e){
  		console.log("서버와 접속이 끊김");
  		//끊기는 시점을 발견할때, 1초의 시간 뒤에 다시 재접속하여 프로그램의 
  		//안정성을 높이자
  		setTimeout("connect()", 1000);
  	}
  	ws.onerror=function(e){
  		console.log("에러발생 ",e);
  	}
  }
  
  

  	
  	//내가보낸메세지_이미지
  	function showMessageRightCard(msg){
  		//현재 시간구하기
  		let time = new Date().getHours() + ":" + new Date().getMinutes();
  		
  		//time, content
  		let messageRightCard = new MessageRightCard(time, msg);
  		$("#chatArea").append(messageRightCard.getBox());	
  		$("#chatAreaScroll").scrollTop($("#chatAreaScroll")[0].scrollHeight);
  		
  	}
  	
  	//내가받은메세지_이미지
  	function showMessageLeftCard(chat, msg){
  		//현재 시간구하기
  		let time = new Date().getHours() + ":" + new Date().getMinutes();
  		
  		//profile, name, time, content
  		let messageLeftCard = new MessageLeftCard("https://bootdey.com/img/Content/avatar/avatar5.png", chat.member.member_nickname, time, msg);
  		$("#chatArea").append(messageLeftCard.getBox());	
  		$("#chatAreaScroll").scrollTop($("#chatAreaScroll")[0].scrollHeight);
  	}
  	
  	
  	function sendMsg(chat, msg){
  		
  		console.log("sendMsg() chat", chat);
		
		//protocol: RoomNum, 보내는id, 내용 
		ws.send(chat.chat_idx + "," + chat.member_teacher.member_idx + "," + chat.member.member_idx + "," + msg);
  		
		showMessageRightCard(msg);
  	}
  	
  	/*-------------------------------------------------------------------------------------------
  		채팅방들어가기
  	----------------------------------------------------------------------------------------------*/
  	let app_chatHeader; //채팅방 헤더(프로필, 이름, 삭제)
  	let app_currentHeader; //현재 선택된 채팅방 헤더(정보갱신을 위해)
  	let app_chatFooter; //채팅방 푸터(메세지 전송Area)
  	let app_currentFooter; //현재 선택된 채팅방 헤더(정보갱신을 위해)
  	
  	const chat_header={
  			template:`
	  			<div class="d-flex align-items-center py-1 chat-item-align-left">
	  				<div class="position-relative">
	  					<img src="https://bootdey.com/img/Content/avatar/avatar3.png" class="rounded-circle mr-1" alt="Sharon Lessman" width="40" height="40">
	  				</div>
	  				<div class="flex-grow-0 pl-3">
	  					<strong>{{chat.member.member_nickname}}</strong>
	  				</div>	
	  			</div>
	  			<div class="close-item-box-bg">
	  				<div class="chat-icon mdi mdi-close btn-close-item"></div>
	  			</div>
  			`,
  			props:["obj"],
  			data(){
  				
  				return{
  					chat:this.obj
  				};
  			},
  			created:function(){
  				console.log("header obj : ",this.chat);
  				app_currentHeader = this;
  			}
  	};
  	
  	app_chatHeader = new Vue({
  		el:"#app_chatHeader",
  		components:{
  			chat_header
  		},
  		data:{
  			chat:[],
  			flag:false
  		},
  		
  	});
  	
	const chat_footer={
  			template:`
	  			<div class="chat-textarea">
	  				<textarea class="form-control"  cols="30" placeholder="메세지를 입력하세요..." id="t_content" @keyup="clickEnter($event, chat)"></textarea>
	  				<button class="btn btn-primary" style="float:right;" id="bt_send" @click="clickSend(chat)">전송</button>											
	  			</div>
  			`,
  			props:["obj"],
  			data(){
  				return{
  					chat:this.obj
  				};
  			},
	  		created:function(){
	  			app_currentFooter = this;
	  		},
  			methods:{
  	  			clickSend:function(chat){
  	  				//채팅방 클릭시 채팅내용 출력
  	  				//console.log("seneMsg 호출", chat);
	  					let msg = $("#t_content").val();
	  	  				sendMsg(chat, msg);
	  	  				$("#t_content").val("");
  	  			},
  	  			clickEnter:function(e, chat){
  	  				//console.log("keyup", chat);
  	  				if(e.keyCode == 13 && !e.shiftKey){
  	  					e.preventDefault(); // 엔터키가 입력되는 것을 막아준다.
  	  					let msg = $("#t_content").val();
	  	  				sendMsg(chat, msg);
	  	  				$("#t_content").val("");
  	  				}
  	  			}
  	  		}
  	};
  	
  	app_chatFooter = new Vue({
  		el:"#app_chatFooter",
  		components:{
  			chat_footer
  		},
  		data:{
  			chat:[],
  			flag:false
  		}
  	});
  	
	//chatArea에 메세지 목록 불러오기
  	function chatAreaMesseges(chat){
  	  
  		$("#chatArea").empty(); //div내용지우기
  		
  		$.ajax({
            url:"/rest/chat/chatmessage/"+chat.chat_idx,
            type:"get",
			contentType:"application/json;charset=utf-8",
            processData:false, /*query string화 여부*/
            success:function(result, status, xhr){
               console.log("선생님이 조회한 메세지 목록", result);
               for(let i=0;i<result.length;i++){
					//console.log(result[i]);
					//console.log(chat);
            	   chatAreaMessegesAppend(chat, result[i]);
               }
           }
       });
  		
  		
  	}
	
	//db에 저장된 message내역들을 chatArea에 붙여넣자
	function chatAreaMessegesAppend(chat, result){
		//console.log(result);
		//console.log(chat);
		if(result.you == chat.member_teacher.member_idx){
			showMessageLeftCard(chat, result.message_content);  		
		}else{
			showMessageRightCard(result.message_content);
		}
		$("#chatAreaScroll").scrollTop($("#chatAreaScroll")[0].scrollHeight);
	}
	
	//읽음표시 0 -> 1 업데이트 실행
	function messageCheck(chat){
		console.log("업데이트 실행 ", chat);
		let messageList = chat.messageList;
  		/*
	  		{
					"message_check": "0",
					"message_idx":"0"
				}
			}
  		*/

		let sendList=[];
		for(let i=0;i<messageList.length;i++){
			let message = messageList[i];
			if(message.me == chat.member.member_idx && message.message_check == 0){
		  		sendList.push(message);
			}
		}
			console.log(JSON.stringify(sendList));
			
			$.ajax({
	            url:"/rest//chat/chatmessage/check",
	            type:"post",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(sendList),
				processData:false, 
	            success:function(result, status, xhr){
	               console.log("업데이트", result);
	               console.log(result.msg);
	               getChatRooms();
			     }
	       });
  		
	}
  	
  	function getChatHeadFoot(chat){
  		//채팅방 이름,프로필 위에 뜨는거, 밑에 메세지 전송창 불러오기(채팅방 클릭시 해당 채팅방 헤더 및 메세지전송창)
  		console.log("채팅방 클릭시", chat);
  		
  		$("#chatArea").empty(); //div내용지우기
  		
  		
  		app_chatHeader.chat = chat;
  		app_chatHeader.flag = true;
  		if(app_currentHeader != undefined){
	  		app_currentHeader.chat=chat;
  		}
  		
  		app_chatFooter.chat = chat;
  		app_chatFooter.flag = true;
  		if(app_currentFooter != undefined){
  			app_currentFooter.chat=chat;
  		}
  		
  		chatAreaMesseges(chat); //채팅방 메세지 목록 불러오기
  		messageCheck(chat); //읽음 체크하기 0-> 1
  		
  		connect(chat); //웹소켓 연결
  		//console.log("확인",chat.member.member_idx);
  	}
 
  	
  	
  	/*------------------------------------------------------------------------------------------
  	채팅목록, 채팅방생성 관련
  	---------------------------------------------------------------------------------------------*/
    //비동기방식관련
    let app_chatRooms; //채팅목록
  	
  	const row={
  			template:`
  				<a href="#" class="list-group-item list-group-item-action border-0" @click="getChat(chat)">
  				<div class="badge bg-success float-right">{{totalMessageCheck}}</div>
  					<div class="d-flex align-items-start">
  							<img src="https://bootdey.com/img/Content/avatar/avatar5.png" class="rounded-circle mr-1" alt="Vanessa Tucker" width="40" height="40">
  						<div class="chatname flex-grow-1 ml-3">
  											{{chat.member.member_nickname}}
  							<div class="chatmessage">{{showLastMessage}}</div>
  						</div>
  					</div>
  				</a>
  			`,
  			props:["obj"],
  			data(){
  				return{
  					chat:this.obj,
  					totalMessageCheck:0,
  					showLastMessage:""
  				};
  			},
  			methods:{
  	  			getChat:function(chat){
  	  				//채팅방 클릭시 채팅내용 출력
  	  				console.log("getChat 호출", chat);
  	  				getChatHeadFoot(chat);
  	  			}
  	  		},
  	  		created:function(){
  	  			let messageList = this.obj.messageList;
  	  			let count = 0;
  	  			let lastMessage = "";
  	  			for(let i=0;i<messageList.length;i++){
  	  				let message = messageList[i];
  	  				if(message.me == this.obj.member.member_idx){
  	  					lastMessage = message.message_content;
  	  					if(message.message_check==0){
  	  						count++;
  	  					}
  	  				}
  	  			}
  	  			this.totalMessageCheck = count;
  	  			this.showLastMessage = lastMessage;
  	  			//console.log("lastMessage : ",lastMessage);
  	  		}
  	};
  	
  	app_chatRooms = new Vue({
  		el:"#app_chatRooms",
  		components:{
  			row
  		},
  		data:{
  			chatList:[]
  		}
  	});
  	
  	
  	//채팅목록 불러오기
  	function getChatRooms(){
  		
		let obj={};
  		let json={};
		
  		json['member_idx']=parseInt($("#chatMember option:checked").val()); //수강생 member_idx);
  		obj['member']=json;
  		
  		//조회할때는 member.member_idx에 "0"이 넘어감
  		console.log("채팅목록",obj);
  		
		$.ajax({
			url:"/rest/teacher/chat/message/selectAll",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(obj),
			processData:false, /*query string화 여부*/
			success:function(result, status, xhr){
				app_chatRooms.chatList = result;
				console.log(result);
			}
		});
  	}
  	
  	
  	//수강생에게 보낼 채팅방 생성 또는 이동하기
  	function chatRoom(){
  		/*
  		{
  			"member"{
  				member_idx:5
  			}
  		}
  		*/
		let obj={};
  		let json={};
		
  		json['member_idx']=parseInt($("#chatMember option:checked").val()); //수강생 member_idx);
  		obj['member']=json;
		
		console.log("생성/이동 json",obj);
		
		$.ajax({
			url:"/rest/teacher/chat/message",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(obj),
			processData:false, /*query string화 여부*/
			success:function(result, status, xhr){
				console.log("생성/이동 result", result);
				getChatRooms(); //채팅방조회
  				getChatHeadFoot(result); //채팅방 헤더푸터
			}
		});
  	}


  	
  	/*------------------------------------------------------------------------------------------*/
  	
	$(function(){
		//selectShowHide(flag); //기본 : 채팅방검색
		//connect();
		getChatRooms(); //채팅방리스트 조회
		
		/*
		//2초에 한번씩 채팅목록 불러오기(채팅 알림전용)
		setInterval(function(){
			
		},2000);
		*/
		
		
		
		//selectbox눌렀을 때 모달창 띄우기
		$("#chatMember").change(function(e){
			let chatMemberChecked = $("#chatMember option:checked").text();
			$('#myModal').modal('show');
			
			$(".modal-body").html(chatMemberChecked+"님께 메세지를 보내시겠습니까?");
			
		});
		
		//모달창의 확인버튼 눌렀을때
  		$("#bt_messageOk").click(function(){
  			$('#myModal').modal('hide');
			chatRoom();
  		});
		
	});  	
  </script>

</html>
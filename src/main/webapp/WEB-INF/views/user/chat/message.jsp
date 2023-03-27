<%@page import="com.edu.zino.domain.OrderSummary"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<OrderSummary> orderSummaryMemberTeacherList = (List)request.getAttribute("orderSummaryMemberTeacherList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Chat-Message</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- header_link -->
	<jsp:include page="../inc/header_link.jsp"></jsp:include>
	<!-- header_link end -->

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

	<!-- hero-content -->
    <div class="page-header">
    	<!-- header-->
		<jsp:include page="../inc/page/header.jsp"></jsp:include>
		<!-- header end -->
    	<jsp:include page="../inc/page/header_main.jsp"></jsp:include>
    </div>
    <!-- hero-content end-->
	
	
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<!-- partial:partials/_sidebar.html -->
				<jsp:include page="../inc/mypage/sidebar.jsp"></jsp:include>
				 <!-- sidebar.html end  -->
			</div>
			<div class="col-md-9">
			<div class="chat-container p-0">
		<div class="card-chat">
			<div class="row-chat g-0">
			
			<!-- 채팅방 -->
				<div class="col-12 col-lg-5 col-xl-4 border-right">

					<div class="px-4 d-none d-md-block">
						<div class="d-flex align-items-center">
							<div class="flex-grow-1"  id="selectChat">
								<input type="text" class="form-control my-3" placeholder="대화상대이름..">
							</div>
							<select class="form-control form-control-sm my-3" id="chatMember">
		                        <option value="0">강사를 선택하세요</option>
		                        <% for(int i=0;i<orderSummaryMemberTeacherList.size();i++){ %>
	                        	<%
	                        		OrderSummary orderSummary = orderSummaryMemberTeacherList.get(i);
	                        	%>
		                        <option value="<%= orderSummary.getMember().getMember_idx() %>"><%= orderSummary.getMember().getMember_nickname() %></option>
		                        <% } %>
	                    	</select>
							
							<div class="chat-icon mdi mdi-comment-plus-outline" id="addChat"></div>
						</div>
					</div>

					<section id="app_chatRooms">
						<template v-for="chat in chatList">
							<row :key="chat.member.member_idx" :obj="chat" />
						</template>
					</section>

					<hr class="d-block d-lg-none mt-1 mb-0">
				</div>
				
				<!-- 채팅내용 -->
				<div class="col-12 col-lg-7 col-xl-8">
					<div class="         px-4 border-bottom d-none d-lg-block chat-item-float-overflow">
						
						<section id="app_chatHeader">
							<template v-if="flag">
								<chat_header :key="chat.member_teacher.member_idx" :obj="chat" />
							</template>
						</section>
							
					</div>

					<div class="position-relative" style="height:70%">
						<div class="chat-messages p-4" id="chatArea">


						</div>
					</div>

					<div class="flex-grow-0 py-3 px-4 border-top">

							<section id="app_chatFooter">
								<template v-if="flag">
									<chat_footer :key="chat.member_teacher.member_idx" :obj="chat" />
								</template>
							</section>

					</div>

				</div>
			</div>
		</div>
	</div>
			
			
			
			
			</div>
		</div>	
	</div>
   
	
	<!-- clients_logo -->
    <jsp:include page="../inc/clients_logo.jsp"></jsp:include>
    <!-- clients_logo end -->
    
	<!-- footer -->
	<jsp:include page="../inc/footer.jsp"></jsp:include>
	<!-- footer -->
	<!-- footer_link -->
	<jsp:include page="../inc/footer_link.jsp"></jsp:include>
	<!-- footer_link end-->

</body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/1.0.18/vue.min.js"></script>
<script type="text/javascript">


/*----------------------------------------------------------------------------------------------
웹소켓 메세지 주고받기
--------------------------------------------------------------------------------------------------*/

//websocket관련
	let ws;
	let socket = null;
	let flag = true; //강사 조회하는 폼 보이거나 숨길 때 사용


//웹소켓을 이용한 서버에 접속
function connect(chat){
	ws=new WebSocket("ws://localhost:7777/chat");
	
	ws.onopen=function(){
		console.log("서버에 접속됨 onopen");
		ws.send(chat.chat_idx + "," + chat.member.member_idx + "," + chat.member_teacher.member_idx + "," + "ENTER-CHAT"); //보내는 내용			
	}
	
	ws.onmessage=function(e){
		console.log("서버가 보낸 데이터/유저가 받은 데이터", e.data);
		
		//서버가 보낸 메시지를 area에 누적 
		//$("#t_receive").append(e.data+"\n");
		
		let sm = e.data;
		let sl = sm.split(',');
		let roomNum = sl[0];
		let sendId = sl[1]; //추후 누가 member_idx
		let resiveId = sl[2]; //추후 누구에게 member_idx
		let content = sl[3];
		if(roomNum == chat.chat_idx && sendId != chat.member.member_idx && content != "ENTER-CHAT"){
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
		
	}
	
	//내가받은메세지_이미지
	function showMessageLeftCard(chat, msg){
		//현재 시간구하기
		let time = new Date().getHours() + ":" + new Date().getMinutes();
		
		//profile, name, time, content
		let messageLeftCard = new MessageLeftCard("https://bootdey.com/img/Content/avatar/avatar5.png", chat.member_teacher.member_nickname, time, msg);
		$("#chatArea").append(messageLeftCard.getBox());	
	}
	
	
	function sendMsg(chat, msg){
		
		
		console.log("sendMsg", chat);
		
		//protocol: RoomNum, 보내는id, 내용 
		ws.send(chat.chat_idx + "," + chat.member.member_idx + "," + chat.member_teacher.member_idx + "," + msg);
		
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
	  					<strong>{{chat.member_teacher.member_nickname}}</strong>
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
				console.log("obj : ",this.chat);
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
            url:"/rest/chat/chatMessage",
            type:"post",
			contentType:"application/json;charset=utf-8",
            data:{
               chat_idx:chat.chat_idx
            },
            processData:false, /*query string화 여부*/
            success:function(result, status, xhr){
               console.log("유저가 조회한 메세지 목록", result);
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
				<div class="badge bg-success float-right">5</div>
					<div class="d-flex align-items-start">
							<img src="https://bootdey.com/img/Content/avatar/avatar5.png" class="rounded-circle mr-1" alt="Vanessa Tucker" width="40" height="40">
						<div class="chatname flex-grow-1 ml-3">
											{{chat.member_teacher.member_nickname}}
							<div class="chatmessage">안녕하세요</div>
						</div>
					</div>
				</a>
			`,
			props:["obj"],
			data(){
				return{
					chat:this.obj
				};
			},
			methods:{
	  			getChat:function(chat){
	  				//채팅방 클릭시 채팅내용 출력
	  				console.log("getChat 호출", chat);
	  				getChatHeadFoot(chat);
	  			}
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
		
		json['member_idx']=parseInt($("#chatMember option:checked").val()); //강사 member_idx);
		obj['member_teacher']=json;
		
		//조회할때는 member.member_idx에 "0"이 넘어감
		console.log("채팅목록",obj);
		
		$.ajax({
			url:"/rest/user/chat/message/selectAll",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(obj),
			processData:false, /*query string화 여부*/
			success:function(result, status, xhr){
				app_chatRooms.chatList = result;
				console.log("채팅목록 받은 값", result);
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
		
		json['member_idx']=parseInt($("#chatMember option:checked").val()); //강사 member_idx);
		obj['member_teacher']=json;
		
		console.log("생성/이동",obj);
		
		$.ajax({
			url:"/rest/user/chat/message",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(obj),
			processData:false, /*query string화 여부*/
			success:function(result, status, xhr){
				getChatRooms(); //채팅방조회
				getChatHeadFoot(result); //채팅방 헤더푸터
			}
		});
	}

	//수강생selectbox와 검색창
	function selectShowHide (flag){
		if(flag == true){
	  		$("#selectChat").show(); //보이기
	  		$("#chatMember").hide(); //숨기기  			
		}else {
	  		$("#selectChat").hide(); //보이기
	  		$("#chatMember").show(); //숨기기
		}
	}
	
	/*------------------------------------------------------------------------------------------*/
	
	$(function(){
		selectShowHide(flag); //기본 : 채팅방검색
		//connect();
		getChatRooms(); //채팅방리스트 조회
		
		
		
		//메세지플러스 아이콘 눌렀을 때 수강생selectbox와 검색창
		$("#addChat").click(function(){
			flag = !flag;
			selectShowHide(flag);
		});
		
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
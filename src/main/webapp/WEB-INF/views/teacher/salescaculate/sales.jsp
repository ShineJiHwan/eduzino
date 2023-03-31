<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Plus Admin</title>
    <!-- plugins:css -->
    <jsp:include page="../inc/header_link.jsp"></jsp:include>
  </head>
  <body>
    <div class="container-scroller">
      <!-- partial:partials/_sidebar.html -->
      <jsp:include page="../inc/sidebar.jsp"></jsp:include>
      <!-- sidebar.html end  -->
      
      <!-- partial  -->
        <!-- partial -->
        <!-- partial:partials/_navbar.html -->
        <jsp:include page="../inc/navbar.jsp"></jsp:include>
        <!-- partial -->
        <div class="main-panel">
          <div class="content-wrapper pb-0">
            <div class="page-header flex-wrap">
              <div class="header-left d-flex flex-wrap mt-2 mt-sm-0">
              <div class="btn-group mb-2 mb-md-0 mr-2" role="group" aria-label="Basic example">
                            <button type="button" class="btn btn-outline-secondary" id="day"> 일간 </button>
                            <button type="button" class="btn btn-outline-secondary border-left border-left-sm-0" id="month"> 월간 </button>
                            <button type="button" class="btn btn-outline-secondary" id="year"> 년간 </button>
               </div>
               
                <!-- date -->
                <div class="inputdate mb-2 mb-md-0 mr-2">
		            <input type="text" class="typeDate" name="startendDate" placeholder="버튼을 클릭하세요" readonly>                
                </div>

              </div>
              <div class="header-right d-flex flex-wrap mt-2 mt-sm-0">

			
              
              </div>
            </div>
            
            
            <!-- first row starts here -->
            <div class="row">
              <div class="col stretch-card grid-margin"">
                <div class="card">
                  <div class="card-body">
                       <canvas id="barChart" style="height: 134px; display: block; width: 269px;" width="336" height="167" class="chartjs-render-monitor"></canvas>
                  </div>
                </div>
              </div>
            </div>
            
            
            <!-- table row starts here -->
            <div class="row">
             <div class="col-xl-8 stretch-card grid-margin">
                <div class="card">
                  <div class="card-body pb-0">
                    <h4 class="font-weight-bold mb-0">매출상세</h4>
                  </div>
                  <div class="card-body p-0">
                    <div class="table-responsive" style=" height:230px; overflow:auto;" >
                      <table class="table custom-table text-dark">
                        <thead>
                          <tr>
                            <th>기간</th>
                            <th>매출금액</th>
                          </tr>
                        </thead>
                        <tbody>

							<section id="app_salesTable">
								<template v-for="orderSummary in dateList">
									<row :key="orderSummary_idx" :obj="orderSummary" />
								</template>
							</section>

                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            
              <div class="col-xl-4 grid-margin">
              <div class="card">
                  <div class="card-body">
                    <div class="d-flex border-bottom mb-4 pb-2" style="justify-content: space-between;	">
                    <h4 class="font-weight-bold mb-0">정산</h4>
                    <div class="pl-4">
						<input type="month" name="monthCaculate">

                      </div>
                    </div>
                    <div class="d-flex border-bottom mb-4 pb-2" style="justify-content: space-between;	">
                        <h4 class="font-weight-bold text-success mb-0">매출금액</h4>
                      <div class="pl-4">
                        <h6 class="text-muted">2,750,000</h6>
                      </div>
                    </div>
                    <div class="d-flex border-bottom mb-4 pb-2" style="justify-content: space-between;	">
                        <h4 class="font-weight-bold text-danger mb-0"> 수수료 </h4>
                      <div class="pl-4">
                        <h6 class="text-muted"> -30,000</h6>
                      </div>
                    </div>
                    <div class="d-flex border-bottom mb-4 pb-2" style="justify-content: space-between;	">
                        <h4 class="font-weight-bold text-info mb-0">합계</h4>
                      <div class="pl-4">
                        <h6 class="text-muted">2,720,000</h6>
                      </div>
                    </div>
                  </div>
                </div>
              
              </div>
             </div>
          </div>
          <!-- content-wrapper ends -->
          <!-- partial:partials/_footer.html -->
		  	<jsp:include page="../inc/footer.jsp"></jsp:include>
          <!-- partial:partials/_footer.html end -->
          <!-- partial -->
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
  	
	  /*----------------------------------------------------------
		버튼에 맞는 결제내역 테이블에 넣기
	------------------------------------------------------------*/
	
  	let app_salesTable; //매출내역 테이블
  	
  	/*
  	                       <tr>
                            <td>2023-02-01 ~ 2023-02-28</td>
                            <td>40,234</td>
                          </tr>
  	
  	*/
	
	const salesTable={
  			template:`
	              <tr>
	                <td>2023-02-01 ~ 2023-02-28</td>
	                <td>40,234</td>
	              </tr>
  			`,
  			props:["obj"],
  			data(){
  				return{
  					orderSummary:this.obj
  				};
  			}
  	};
  	
	app_salesTable = new Vue({
  		el:"#app_salesTable",
  		components:{
  			salesTable
  		},
  		data:{
  			dateList:[],
  		}
  	});
	
  	//조회한 일별,월별,년별 데이터 받기
  	function getSales(start_date, end_date){
		let json={};
		let obj={};
		
		json['start_date']=start_date;
		json['end_date']=end_date;
		obj['OrderSummary']=json;
  		
  		console.log(obj);

		$.ajax({
			url:"/rest/teacher/salescaculate/sales",
			type:"post",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(obj),
			processData:false, /*query string화 여부*/
			success:function(result, status, xhr){
				app_salesTable.dateList = result;
				console.log(result);
			}
		});
  	}
	
	
	
	/*----------------------------------------------------------
		버튼에 날짜 이벤트
	------------------------------------------------------------*/
  	let date = new Date();
	let y=date.getFullYear();
	let m=date.getMonth();
	let d=date.getDate();
	let todayMonth; //현재 월
	let todayDay; //현재 일
	let start_date; //시작하는 년월일
	let end_date; //끝나는 년월일
	
	//일간 버튼 클릭시 현재날짜까지 총 12일 조회
	function dayClickInput(){
		
		start_date = y+todayMonth+(d-11);
		end_date = y+todayMonth+d;
		
		$("input[name=startendDate]").val(y+"-"+todayMonth+"-"+(d-11)+" ~ "+y+"-"+todayMonth+"-"+d);
		
		getSales(start_date, end_date); //매출테이블 반영
	}
	
	//월간 버튼 클릭시 현재달까지 총 12개월 조회
	function monthClickInput (){
		let first = new Date(y,(todayMonth-12),1); //구하고자 하는 달의 첫번째 일
		let firstMonth;
		let firstDay;
		
 		if(first.getMonth() < 10){
				firstMonth = '0'+(first.getMonth()+1);
				firstDay = '0'+first.getDate();	
		}
		
		let last = new Date(y,todayMonth,0);
		
		start_date = first.getFullYear()+firstMonth;
		end_date = y+todayMonth;
		
		$("input[name=startendDate]").val(first.getFullYear()+"-"+firstMont+"-"+firstDay+" ~ "+y+"-"+todayMonth+"-"+last.getDate());
		
		getSales(start_date, end_date); //매출테이블 반영
		
	}
	
	//년간 버튼 클릭시 현재 년도까지 총 12년 조회
	function yearClickInput(){
		let first = new Date((y-11),1,1); //구하고자 하는 달의 첫번째 일
		let firstMonth;
		let firstDay;
		
		if(first.getDate() < 10){
			firstMonth = '0'+first.getMonth();
			firstDay = '0'+first.getDate();
		}
		let last = new Date(y,todayMonth,0);
		
		start_date = first.getFullYear();
		end_date = y;
		
		$("input[name=startendDate]").val(start_date+"-"+firstMonth+"-"+firstDay+" ~ "+end_date+"-12-"+last.getDate());
		
		getSales(start_date, end_date); //매출테이블 반영
	}

	$(function() {
		
		if(m < 10){
			todayMonth = '0'+(m+1);
			todayDay = '0'+d
		}else {
			todayMonth = (m+1);
			todayDay = d
		}
		
		$("input[name=monthCaculate]").val(y+"-"+todayMonth); //정산내역 날짜
		  
		//일간 (총12일)
		$("#day").click(function(){
			dayClickInput();
		});
		
		//월간 (1~12월)
		$("#month").click(function(){
			monthClickInput();
		});
		
		//년간 (12년)
		$("#year").click(function(){
			yearClickInput();
		});


	});
  </script>

</html>
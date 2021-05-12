console.log("modal module...");

function modal(ctx){
    let modalStr = (
        "    <div class='modal' style='display:none;' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-modal='true' style='padding-right: 17px; display: block;'>\n" +
        "        <div class='custom-modal-dialog'>\n" +
        "            <div class='modal-content'>\n" +
        "                <div class='modal-header'>\n" +
        "                    <h4 class='modal-title' id='myModalLabel'>Modal title</h4>\n" +
        "                    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>\n" +
        "                </div>\n" +
        "                <div class='modal-body' id='myModalBody'>content</div>\n" +
        "                <div class='modal-footer' id='myModalFooter'>\n" +
        "                    footer\n" +
        "                </div>\n" +
        "            </div>\n" +
        "        </div>\n" +
        "    </div>"
    );



    function modalSetting(title, body, footer, footerFunc) {


        $("#myModalLabel").html(title);
        $("#myModalBody").html(body);
        footerSetting(footer, footerFunc);

        $(".close").on("click", function () {
            $(".modal").fadeOut();
        });

        function footerSetting(footer, footerFunc) {

            $(".modal-footer > button").unbind("click");

            let alert = "<button type='button' class='btn btn-primary' data-is='ok' data-dismiss='modal'>확인</button>";
            let confirm = "<button type='button' class='btn btn-primary' data-is='ok' data-dismiss='modal'>확인</button>" +
                "<button type='button' class='btn btn-danger' data-is='cancel' data-dismiss='modal'>취소</button>";


            if(footer !== undefined) {
                if(footer === 'alert')
                    $("#myModalFooter").html(alert);
                if(footer === 'confirm')
                    $("#myModalFooter").html(confirm);

                $("#myModalFooter").show();
            }
            else $("#myModalFooter").hide();

            $(".modal-footer > button").on("click",function () {
                if(this.dataset.is === 'ok') {
                    if(footerFunc !== undefined) footerFunc();
                    else console.log('확인버튼이 클릭되었으나 지정된 function 이 존재하지 않습니다')
                }
                else {
                    console.log("cancel");
                }
                $(".modal").fadeOut();
            });
        }
    }


    function modalCssSetting(width){
        $(".custom-modal-dialog").css('width', (width || 500) + 'px');
    }

    $(ctx).html(modalStr);
    modalCssSetting();


    return {
        hide : function (){
            $(".modal").fadeOut();
        },
        show :function (){
            $("#myModal").fadeIn();
        },
        modalSetting : modalSetting,
        modalCssSetting : modalCssSetting
    };
}
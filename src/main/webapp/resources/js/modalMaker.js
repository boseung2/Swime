

function modal(ctx){
    let modalStr = (
        "    <div class='modal' style='display:none;' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-modal='true' style='padding-right: 17px; display: block;'>\n" +
        "        <div class='modal-dialog'>\n" +
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



    $("#myModal > div > div > div.modal-header > button").click(function(){
        $(".modal").fadeOut();
    });

    $(".modal-footer > button").click(function(){
        $(".modal").fadeOut();
    });



    function modalSetting(title, body, footer, footerAct) {
        $("#myModalLabel").html(title);
        $("#myModalBody").html(body);
        footerSetting(footer);




        function footerSetting(footer, footerAct) {

            $(".modal-footer > button").unbind("click");

            let alert = "<button type='button' class='btn btn-primary' data-dismiss='modal'>확인</button>";
            let confirm = "<button type='button' class='btn btn-primary' data-dismiss='modal'>확인</button>" +
                "<button type='button' class='btn btn-danger' data-dismiss='modal'>취소</button>";


            if(footer !== undefined) {
                if(footer === 'alert')
                    $("#myModalFooter").html(alert);
                if(footer === 'confirm')
                    $("#myModalFooter").html(confirm);

                $("#myModalFooter").show();
            }
            else $("#myModalFooter").hide();

            $(".modal-footer > button").on("click",function () {
                if(footerAct !== undefined) footerAct();
                else $(".modal").fadeOut();
            });
        }
    }

    this.modalHide = function (){
        $(".modal").fadeOut();
    };
    this.modalShow = function (){
        $("#myModal").fadeIn();
    };
    this.modalSetting = function (){
        modalSetting();
    };
    $(ctx).html(modalStr);
};
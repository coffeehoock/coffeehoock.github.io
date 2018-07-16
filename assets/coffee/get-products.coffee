$(document).ready =>
	
	__FILE_INDEX__ = "https://raw.githubusercontent.com/coffeehoock/Test_task_front2/master/products.json"
	
	productNum = 0
	openProductNum = 10
	alreadyOpen = 0
	
	@ProductsAddCart = new Array
	
	getPush = ( prod ) ->
		@ProductsAddCart.push prod
	
	@recommenceBtnProd = ->
		i = 0
		while i < @ProductsAddCart.length
			$( @ProductsAddCart[i] ).find('.btn.btn_cart').css { 'background': '#ff6b6b' }
				.find('.ng-binding').html 'добавлен'
			
			i++
	
	@recommenceBtnProdTimeout  = ->
		setTimeout ->
			do @recommenceBtnProd
		,1000
	
	stepperVal = 0
	
	@openProduct = ->
		if alreadyOpen <= productNum
			i = 0
			while i < alreadyOpen
				$('#prodId-' + i).fadeIn 'show'
				i++
			return updateOpenNum()
		else
			$('.open-product__btn').html "товаров больше нет"
			$('.open-product__btn').css { 'background': '#ffa822' }
			$('.open-product__btn--to').fadeIn 'show'
	
	@openProductSort = ->
		alreadyOpen = 10
		if alreadyOpen <= productNum
			i = 0
			while i < alreadyOpen
				$('#prodId-' + i).fadeIn 'show'
				i++
			return updateOpenNum()

	
	@addProdBasket = ->
		$.get __FILE_INDEX__,  ( data ) ->
			productData = JSON.parse data
			
			if typeof  productData is "object" and  !!productData?
				###
		            decor btn
				###
#			$.each productData, ( i, prod ) ->
				$(".btn.btn_cart").on 'click' ,->
					### get id selector ###
					getPush '#' + $(@).parent().parent().parent().attr('id')

					if $(@).find('.ng-binding').html() is 'добавлен'
						return false
					
					else
						$(@).css({'background': '#ff6b6b'})
						$(@).find('.ng-binding').html 'добавлен'
						basket += parseFloat $(@).parent().parent().find('.product__count.stepper-input').val()
						$('#num').html parseFloat basket
						$(@).parent().parent().find('.list--unit-desc').css({ 'opacity': '1' })
						
						do basketEmpty
				
				$('.stepper-arrow.up').on 'click' ,->
					self = parseFloat $(@).parent().parent().find('.product__count.stepper-input').val()
					self += 1
					$(@).parent().parent().find('.product__count.stepper-input').val self
				
				$('.stepper-arrow.down').on 'click' ,->
					if parseFloat $(@).parent().parent().find('.product__count.stepper-input').val()
						self = parseFloat $(@).parent().parent().find('.product__count.stepper-input').val()
						self -= 1
						$(@).parent().parent().find('.product__count.stepper-input').val self
	
	productsComponent = ( id ,code ,isActive ,primaryImageUrl ,title ,assocProducts ,productId ,unitAlt ,unitFull ,priceGoldAlt ,priceRetailAlt ,unitRatioAlt ) =>
		
		code = code.substr(5)
		
		if isActive is true
			isActive = "Наличие"
			isActiveColor = '#093'
		else
			isActive = "Нет в наличие"
			isActiveColor = 'red'
		
		"
		    <div class=\"products_page pg_0\" id=\"prodId-#{ id }\" style=\"display: none\">
		        <div class=\"product product_horizontal\">
		            <span class=\"product_code\">Код: #{ code }</span>
		            <div class=\"product_status_tooltip_container\">
		                <span class=\"product_status\" style=\"color: #{ isActiveColor }\">#{ isActive }</span>
		            </div>
		            <div class=\"product_photo\">
		                <a href=\"#\" class=\"url--link product__link\">
		                    <img src=\"https:#{ primaryImageUrl }\" onload=\"this.style.opacity = '1'\">
		                </a>
		            </div>
		            <div class=\"product_description\">
		                <a href=\"#\" class=\"product__link\">#{ title }</a>
		            </div>
		            <div class=\"product_tags hidden-sm\">
		                <p>Могут понадобиться:</p>
		            </div>
		            <div class=\"product_units\">
		                <div class=\"unit--wrapper\">
		                    <div class=\"unit--select unit--active\">
		                        <p class=\"ng-binding\">За #{ unitAlt }.</p>
		                    </div>
		                    <div class=\"unit--select\">
		                        <p class=\"ng-binding\">За #{ unitFull }</p>
		                    </div>
		                </div>
		            </div>
		            <p class=\"product_price_club_card\">
		                <span class=\"product_price_club_card_text\">По карте<br>клуба</span>
		                <span class=\"goldPrice\">#{ priceGoldAlt }</span>
		                <span class=\"rouble__i black__i\">
		                    <svg version=\"1.0\" id=\"rouble__b\" xmlns=\"http://www.w3.org/2000/svg\" x=\"0\" y=\"0\" width=\"30px\" height=\"22px\" viewBox=\"0 0 50 50\" enable-background=\"new 0 0 50 50\" xml:space=\"preserve\">
		                       <use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"#rouble_black\"></use>
		                    </svg>
		                 </span>
		            </p>
		            <p class=\"product_price_default\">
		                <span class=\"retailPrice\">#{ priceRetailAlt }</span>
		                <span class=\"rouble__i black__i\">
		                    <svg version=\"1.0\" id=\"rouble__g\" xmlns=\"http://www.w3.org/2000/svg\" x=\"0\" y=\"0\" width=\"30px\" height=\"22px\" viewBox=\"0 0 50 50\" enable-background=\"new 0 0 50 50\" xml:space=\"preserve\">
		                       <use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"#rouble_gray\"></use>
		                    </svg>
		                 </span>
		            </p>
		            <div class=\"product_price_points\">
		                <p class=\"ng-binding\">Можно купить за #{ unitRatioAlt } балла</p>
		            </div>
		            <div class=\"list--unit-padd\"></div>
		            <div class=\"list--unit-desc\">
		                <div class=\"unit--info\">
		                    <div class=\"unit--desc-i\"></div>
		                    <div class=\"unit--desc-t\">
		                        <p>
		                            <span class=\"ng-binding\">Продается упаковками:</span>
		                            <span class=\"unit--infoInn\">1 упак. = 2.47 м. кв. </span>
		                        </p>
		                    </div>
		                </div>
		            </div>
		            <div class=\"product__wrapper\">
		                <div class=\"product_count_wrapper\">
		                    <div class=\"stepper\">
		                        <input class=\"product__count stepper-input\" type=\"text\" value=\"1\">
		                        <span class=\"stepper-arrow up\"></span>
		                        <span class=\"stepper-arrow down\"></span>
		                    </div>
		                </div>
		                <span class=\"btn btn_cart\" data-url=\"/cart/\" data-product-id=\"#{ productId }\">
		                    <svg class=\"ic ic_cart\">
		                       <use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"#cart\"></use>
		                    </svg>
		                    <span class=\"ng-binding\">В корзину</span>
		                </span>
		            </div>
		        </div>
		    </div>
		"
	
	###
	    loading product and sort op down
	###
	@getProdDataPriceUp = ( callback ) ->
		
		$( '#products_section' ).html ''
		$.get __FILE_INDEX__, ( data ) ->
			productData = JSON.parse data
			
			productData.sort ( a, b ) ->
				b.priceGoldAlt - a.priceGoldAlt
			
			if typeof  productData is "object" and !!productData?
				
				$.each productData, ( i, prod ) ->
					productNum = i
					$( '#products_section' ).append productsComponent(
						i
					, prod.code
					, prod.isActive
					, prod.primaryImageUrl
					, prod.title
					, prod.assocProducts
					, prod.productId
					, prod.unitAlt
					, prod.unitFull
					, prod.priceGoldAlt
					, prod.priceRetailAlt
					, prod.unitRatioAlt
					)
			if callback
				do callback
	
	
	@getProdDataPriceDown = ( callback ) ->
		
		$( '#products_section' ).html ''
		$.get __FILE_INDEX__, ( data ) ->
			productData = JSON.parse data
			
			productData.sort ( a, b ) ->
				a.priceGoldAlt - b.priceGoldAlt
			
			if typeof  productData is "object" and !!productData?
				
				$.each productData, ( i, prod ) ->
					productNum = i
					$( '#products_section' ).append productsComponent(
						i
					, prod.code
					, prod.isActive
					, prod.primaryImageUrl
					, prod.title
					, prod.assocProducts
					, prod.productId
					, prod.unitAlt
					, prod.unitFull
					, prod.priceGoldAlt
					, prod.priceRetailAlt
					, prod.unitRatioAlt
					)
			if callback
				do callback

	###
	    upgrade  product  assocProducts
	###
	$.get __FILE_INDEX__,  ( data ) ->
		productData = JSON.parse data
		
		if typeof  productData is "object" and  !!productData?
			
			$.each productData, ( i, prod ) ->
				assocProducts = prod.assocProducts.split(';')
				for  assoc in assocProducts
					assocAppend = "<a href=\"#\" class=\"url--link\">#{ assoc },</a>"
					$("#prodId-#{ i }").find('.product_tags.hidden-sm').append assocAppend
	
	
	###
	    function upgrade
	###
	basket = null
	
	basketEmpty = ->
		if $('#num').text() is ""
			$('#num-product').fadeOut('show')
		else
			$('#num-product').fadeIn('show')
	
	@getProdDataPriceUp @openProduct
	do @addProdBasket

	
	###product discovery###
	updateOpenNum = ->
		alreadyOpen += openProductNum
	
	updateOpenNum()
	


	$('.open-product__btn').on 'click', ->
		openProduct()
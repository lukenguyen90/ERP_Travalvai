/**
* A ColdBox Enabled virtual entity service
*/
component extends="cborm.models.VirtualEntityService" singleton{
	/**
	* Constructor
	*/
	function init(){
	    return this;
	}

	function numberFormat(any number) {
		var rs = isnull(number) ? 0 : number;
		return numberFormat(rs, "9.99");
	}

	public any function roundDecimalPlaces(any value, any places) {
        if (places <= 0)
            return value;
        if (isNull(value)) return 0;
        else if (value == 0) return value;
        
        //Create number format according to needed decimal places
        var decimalFormat = "0.";
        places = (Abs(value) >= 1) ? places : places - 1;
        for(var i = 0; i < places; i++) {
            decimalFormat &= "0";
        }
        //Positive number
        if (Abs(value) >= 1)
            return JavaCast("double", NumberFormat(value, decimalFormat));
        var isNagative = value < 0;
        value = isNagative ? (value*-1) : value;
        var log10 = Int(Log10(value));
       
        var exp = (10 ^ log10);     
        value /= exp;
        value = JavaCast("double", NumberFormat(value, decimalFormat));
        value *= exp;
        value = isNagative ? (value * -1) : value;
        return value;
    }
}

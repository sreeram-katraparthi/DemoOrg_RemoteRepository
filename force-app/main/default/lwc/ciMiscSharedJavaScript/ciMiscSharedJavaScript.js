const getYoY = (data) =>{
    let current_year= new Date().getFullYear();
    let previous_year= current_year-1;
    let yoy = ((data[current_year] - data[previous_year])/data[previous_year])*100;
    return yoy;   
};
export {getYoY};